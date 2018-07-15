%直方体のパッチ作成用データを計算
function [PatchData_XX,PatchData_YY,PatchData_ZZ] = GeoPatMakeBlock2(VertexData2)

Index_Patch = [4,7,8,6];
nn_pat = 1;

for ii_pat=1:nn_pat
    PatchData_XX(:,ii_pat) = VertexData2(Index_Patch(ii_pat,:),1);
    PatchData_YY(:,ii_pat) = VertexData2(Index_Patch(ii_pat,:),2);
    PatchData_ZZ(:,ii_pat) = VertexData2(Index_Patch(ii_pat,:),3);
end
end
