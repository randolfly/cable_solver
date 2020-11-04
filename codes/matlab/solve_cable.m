function out_points = solve_cable(points, lengths)
    %myFun - Description
    %
    % Syntax: out_points = solve_cable(points, lengths)
    % points: 3x3: 3 3d points
    % lengths: 3x1: 3 length
    %
    % Long description
    % 给定points, length,输出计算的cable位置(事实上就是求三个球面交点)
    point1 = points(1, :);
    point2 = points(2, :);
    point3 = points(3, :);
    a11 = 2 * (point3(1) - point1(1));
    a12 = 2 * (point3(2) - point1(2));
    a13 = 2 * (point3(3) - point1(3));
    a21 = 2 * (point3(1) - point2(1));
    a22 = 2 * (point3(2) - point2(2));
    a23 = 2 * (point3(3) - point2(3));
    b1 = lengths(1)^2 - lengths(3)^2 - point1(1)^2 - point1(2)^2 - point1(3)^2 + point3(1)^2 + point3(2)^2 + point3(3)^2;
    b2 = lengths(2)^2 - lengths(3)^2 - point2(1)^2 - point2(2)^2 - point2(3)^2 + point3(1)^2 + point3(2)^2 + point3(3)^2;
    a1 = a11 / a13 - a21 / a23;
    a2 = a12 / a13 - a22 / a23;
    a3 = b2 / a23 - b1 / a13;
    a4 = -(a2) / a1;
    a5 = -(a3) / a1;
    a6 = (-a21 * a4 - a22) / a23;
    a7 = (b2 - a21 * a5) / a23;
    a = a4^2 + 1.0 + a6^2;
    b = 2.0 * a4 * (a5 - point1(1)) - 2.0 * point1(2) + 2.0 * a6 * (a7 - point1(3));
    c = a5 * (a5 - 2.0 * point1(1)) + a7 * (a7 - 2.0 * point1(3)) + point1(1)^2 + point1(2)^2 + point1(3)^2 - lengths(1)^2;
    y_minus = (-b - sqrt(b^2 - 4 * a * c)) / (2.0 * a);
    y_plus = (-b + sqrt(b^2 - 4 * a * c)) / (2.0 * a);
    
    temp_points(1, :) = [a4 * y_plus + a5, y_plus, a6 * y_plus + a7];
    temp_points(2, :) = [a4 * y_minus + a5, y_minus, a6 * y_minus + a7];

    vector1 = (points(2,:)-points(1,:))/norm(points(2,:)-points(1,:));
    vector2 = (points(3,:)-points(1,:))/norm(points(3,:)-points(1,:));
    cross_vector = cross(vector1, vector2);
    validate_vector_1 = (temp_points(1,:)-points(1,:))/norm(temp_points(1,:)-points(1,:));
    % validate_vector_2 = (temp_points(2,:)-points(1,:))/norm(temp_points(2,:)-points(1,:));
    dot_product_1 = dot(cross_vector, validate_vector_1);
    % dot_product_2 = dot(cross_vector, validate_vector_2);
    if dot_product_1>0
        out_points = temp_points(1,:);
    else
        out_points = temp_points(2,:);
    end
end
