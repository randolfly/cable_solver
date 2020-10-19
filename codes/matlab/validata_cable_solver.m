% load data
pos_data = load('../../models/pos_data.txt');
disp('load txt successfully');

lengths = pos_data(:,1:3);
input_points_1 = pos_data(:,4:6);
input_points_2 = pos_data(:,7:9);
input_points_3 = pos_data(:,10:12);
validate_points = pos_data(:,13:15);

% 对points做前处理(转换为y,z,x格式)
input_points_1 = circshift(input_points_1, [0, -1]);
input_points_2 = circshift(input_points_2, [0, -1]);
input_points_3 = circshift(input_points_3, [0, -1]);

input_points = cat(3, input_points_1,input_points_2,input_points_3);
output_points = zeros(size(validate_points));
temp_point = zeros(2,3);

disp('pre possess successfully');

for index = 1:length(output_points)
    temp_point = solve_cable(squeeze(input_points(index,:,:))',lengths(index,:));
    output_points(index,:) = temp_point(1,:);
end


% 对points做后处理(转换为x,y,z格式)
output_points = circshift(output_points, [0,1]);

% 观察差值
delta_vec = validate_points - output_points;
delta_value = vecnorm(delta_vec');

disp('post possess successfully');


disp(['max error: ', num2str(max(delta_value))]);
disp(['mean error: ', num2str(mean(delta_value))]);

plot(1:length(delta_value),delta_value)
xlabel('index of data')
ylabel('norm(2) error of calculation between validation data')
title('solver cal norm(2) error')