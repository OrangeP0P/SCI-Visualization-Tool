clc
clear
close

%% 数据读取
data = readNPY('Example Data\a1_3D_Points_n_Domains.npy');
num_s = 118; % 一个域包含的样本数 | Samples in one domain
num_d = 2; % 域的个数 | Number of domains

%% 3D可视化
num = 100; % 设定球面由多少个面组成 | Set the faces of the "sphere"
[X,Y,Z] = sphere(num); % 生成一个半径为1的球 | Generate a ball with "r=1"
r = 0.016; % 指定球体的半径 | Set r
xlim([0 1])
ylim([0 1])
zlim([0 1])

MappedFlattened(:,1) = normalizeVector(data(:,1), 0, 3); % 归一化 | Normalization
MappedFlattened(:,2) = normalizeVector(data(:,2), 0, 1); % 归一化 | Normalization
MappedFlattened(:,3) = normalizeVector(data(:,3), 0, 1); % 归一化 | Normalization
MappedData = reshape(MappedFlattened, size(data));

figure(1)
for domain = 1:num_d
    if domain <= 1 % 指定域1颜色 | Set the color of domain one
        color_index = colormap("summer"); % 生成颜色地图 | Generate the colourmap
        color_index = color_index(1:2:256,:,:);
    else
        color_index = colormap("cool"); % 生成颜色地图 | Generate the colourmap
        color_index = color_index(1:2:256,:,:);
    end
    for sample = 1:num_s 
        c = zeros(size(X)); % 三维电极球体上色矩阵 | Generate the colour matrix
        for i = 1:1:length(c(1,:))
            for j = 1:1:length(c(:,1))
                c(i,j,1) = color_index(sample,1); % RGB R
                c(i,j,2) = color_index(sample,2); % RGB G
                c(i,j,3) = color_index(sample,3); % RGB B
            end
        end
        s_1 = surf(X*r + MappedData(sample+118*(domain-1),1), Y*r + MappedData(sample+118*(domain-1),2), ...
                   Z*r + MappedData(sample+118*(domain-1),3), c); % 绘制不同样本的球体 | Plot sphere of samples
        s_1.EdgeColor = 'none'; % 球体表面取消指示线 | Hide line on faces
        material(s_1,"metal") % 设置材质 | Set material
        hold on
    end
    
    hold on
end

set(gca,'FontName','Arial','FontSize',10); % 设置绘图字体 | Set Font
set(gca, 'TickDir', 'in'); % 设置所有刻度朝内 | Set the direction of ticks
set(gca, 'box', 'on'); % 打开边框 | Turn on the box
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])
set(gca,'zticklabel',[])
% xlabel('x')
% ylabel('y')
% zlabel('z')
l = light; % 进行打光 | Set light one
l.Color = [1 1 1]; % 使用稍暗的白光 | Set light white
l.Position = [3, 0, 0]; % 光源位于z轴上方，略微偏离中心 | Set light position
l2 = light; % 进行打光 | Set light two
l2.Color = [1 1 1]; % 使用稍暗的白光 | Set light white
l2.Position = [3, 0, 0]; % 光源位于z轴上方，略微偏离中心 | Set light position
view(45, 20); % 设置观察视角
