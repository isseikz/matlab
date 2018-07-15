%’¼•û‘Ì‚Ì’¸“_‚ÌÀ•W‚ğŒvZ
function VertexData2 = GeoVerMakeBlock2(Location,Orientation,SideLength)

r2 = Location;
R2 = Orientation;

Lx2 = SideLength(1);
Ly2 = SideLength(2);
Lz2 = SideLength(3);

VertexData2_0 = [Lx2*ones(8,1), Ly2*ones(8,1), Lz2*ones(8,1)]...
    .*[-0.5,-0.5,-0.5;
    0.5,-0.5,-0.5;
    -0.5,0.5,-0.5;
    -0.5,-0.5,0.5;
    0.5,0.5,-0.5;
    -0.5,0.5,0.5;
    0.5,-0.5,0.5;
    0.5,0.5,0.5];

n_ver = 8;

for i_ver=1:n_ver
    
    VertexData2(i_ver,:) = r2 + VertexData2_0(i_ver,:)*R2';
end
end