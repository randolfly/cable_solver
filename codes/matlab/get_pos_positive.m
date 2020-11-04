function posture = get_pos_positive(points, lengths)
%myFun - Description
%
% Syntax: posture = get_pos_positive(points, lengths)
%
% Long description
% points: 6x3 store all position of base points
% lengths: 6x1 store all length of base points
% posture: 3x3 posture matrix

    % define target plane points
    % store by row
    plane_points = zeros(3,3);
    % plane points distance(const)
    plane_point_distance = 1.73205;
    % temp_point = zeros(2,3);
    % transform point form to yzx type
    trans_points = circshift(points, [0,-1]);

    for index = 1:3
        % calculate each point position
        if index==1
            % transform point form to yzx type
            input_points = trans_points(1:3, :);
            input_length = lengths(1:3);
            % transform point form back to xyz type
            plane_points(1,:) = solve_cable(input_points, input_length);
        elseif index==2
            % transform point form to yzx type
            input_points(1:2,:) = trans_points(4:5,:);
            input_points(3,:) = plane_points(1,:);
            input_length(1:2) = lengths(4:5);
            input_length(3) = plane_point_distance;
            plane_points(2,:) = solve_cable(input_points, input_length);
        elseif index==3
            % transform point form to yzx type
            input_points(1,:) = trans_points(6,:);
            input_points(2,:) = plane_points(1,:);
            input_points(3,:) = plane_points(2,:);

            input_length(1) = lengths(6);
            input_length(2) = plane_point_distance;
            input_length(3) = plane_point_distance;

            plane_points(3,:) = solve_cable(input_points, input_length);
        end
    end

    % transform point form back to xyz type
    plane_points = circshift(plane_points, [0,1]);

    % local x axis pass the point wich connects 3 cables point
    point_1 = plane_points(1,:);
    point_2 = plane_points(2,:); 
    point_3 = plane_points(3,:); 

    center_point = (point_1+point_2+point_3)/3;
    x_vec = (point_1-center_point)/norm(point_1-center_point);
    temp_vec = (point_2-center_point)/norm(point_2-center_point);
    z_vec = cross(x_vec, temp_vec)/norm(cross(x_vec, temp_vec));
    y_vec = cross(z_vec, x_vec)/norm(cross(z_vec, x_vec));

    posture = [x_vec;y_vec;z_vec]';
end