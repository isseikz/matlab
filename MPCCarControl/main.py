#! /usr/bin/python
# -*- coding: utf-8 -*-

import cvxpy
import numpy as np
from cvxpy import *
import matplotlib.pyplot as plt
from math import *
import time

dt = 0.1  # [s] discrete time
lr = 1.0  # [m]
T = 10  # number of horizon

def LinealizedModel(xb, u, dt, lr):
    x     = xb[0]
    y     = xb[1]
    theta = xb[2]
    v     = xb[3]
    phi   = xb[4]

    a     = u[0]
    dPhi  = u[1]

    A = np.eye(xb.shape[0])
    A[0, 2] = dt * sin(theta) * -v
    A[0, 3] = dt * cos(theta)
    A[1, 2] = dt * cos(theta) *  v
    A[1, 3] = dt * sin(theta)
    A[2, 3] = dt * tan(phi) / lr
    A[2, 4] = dt * v / (lr * cos(phi) **2)

    B = np.zeros((xb.shape[0], u.shape[0]))
    B[3, 0] = dt
    B[4, 1] = dt

    C = np.zeros((xb.shape[0], 1))
    C[0] = v * cos(theta)
    C[1] = v * sin(theta)
    C[2] = v * tan(phi) / lr

    return A, B, C


def NonlinearModel(xb, u, dt, lr):
    x     = xb[0]
    y     = xb[1]
    theta = xb[2]
    v     = xb[3]
    phi   = xb[4]

    a     = u[0]
    dPhi  = u[1]

    A = xb
    A[0] += dt * cos(theta) * v
    A[1] += dt * sin(theta) * v
    A[2] += dt * tan(phi)   * v / lr
    A[3] += dt * a
    A[4] += dt * dPhi

    return A


def CalcInput(A, B, C, x, u):

    x_0 = x[:]
    x = Variable(x.shape[0], T + 1)
    u = Variable(u.shape[0], T)

    # MPC controller
    states = []

    # 予測する各区間に対して評価関数と制約の設定をする
    for t in range(T):
        cost = 100 *sum_squares(x[0:2,t+1]) + 0.1 * sum_squares(u[:,t])  # 位置の誤差と入力が小さくなるように評価関数を設定
        constr = [x[:,t+1] == A*x[:,t] + B*u[:,t] + C, norm(u[0,t], 'inf') <= 10, norm(u[1,t], 'inf') <= 1.0] # 運動方程式と入力の範囲が制約条件

        # 終端コストとして速度を設定
        if t == T:
            cost += 10000 * x[3,t+1]**2

        states.append( Problem(Minimize(cost), constr) )

    prob = sum(states)

    # 初期条件を制約に設定
    prob.constraints += [x[:,0] == x_0]
    prob.solve() # 凸最適化

    if prob.status != OPTIMAL:
        print("Cannot calc opt")

    return u, x, prob.value


def GetListFromMatrix(x):
    return np.array(x).flatten().tolist()


def Main():
    x0 = np.matrix([-10.0, 10.0, 0.0, 0.0, 0.0]).T  # [x,y,the, v, phi]
    x = x0
    u = np.matrix([0.0, 0.0]).T  # [a,dPhi]
    plt.figure(num=None, figsize=(12, 12))

    log = np.zeros((8,1))
    state = np.vstack((0.0,x[:,0],u[:,0]))
    log[:,0] = np.squeeze(np.asarray(state))

    for i in range(1000):
        A, B, C = LinealizedModel(x, u, dt, lr)        # 現在の状態周りで系を線形化
        ustar, xstar, cost = CalcInput(A, B, C, x, u)  # 最適入力問題を解いて入力を求める

        # 入力の計算
        u[0, 0] = float(ustar[0, 0].value)
        u[1, 0] = float(ustar[1, 0].value)

        x = NonlinearModel(x, u, dt, lr) # 1ステップだけシミュレーション

        # グラフ描画用はじめ

        state = np.vstack((i*dt,x[:,0],u[:,0]))
        log   = np.hstack((log,np.asarray(state)))

        np.set_printoptions(precision=2, floatmode='fixed', suppress=True)
        print(log[:,i+1].T)

        plt.plot(0,0, 'xb')
        plt.plot(GetListFromMatrix(xstar.value[0, :]), GetListFromMatrix(xstar.value[1, :]), '-b') # 状態ホライズン
        plt.plot(x[0], x[1], '.r') # 実際の位置
        plt.axis("equal")
        plt.xlabel("x[m]")
        plt.ylabel("y[m]")
        plt.grid(True)

        plt.pause(0.0001)

        # グラフ描画用おわり

        # 終了判定はじめ

        val = x[0] **2 + x[1] ** 2 + x[3] ** 2
        if (val < 1.0):
            print("Goal")
            break

        # 終了判定おわり

    # plt.show()

    # 速度・加速度・ハンドル角速度の表示
    plt.figure()

    plt.subplot(2,1,1)
    plt.plot(log[0,:],log[4,:],'r',label='velocity [m/s]')
    plt.xlabel('Time [s]')
    plt.legend()
    plt.grid(True)

    plt.subplot(2,1,2)
    plt.plot(log[0,:],log[6,:],'r',label='acceleration [m/s^2]')
    plt.plot(log[0,:],log[7,:],'b',label='steering     [rad/s]')
    plt.xlabel('Time [s]')
    plt.legend()
    plt.tight_layout()
    plt.grid(True)

    plt.show()


if __name__ == '__main__':
    Main()
