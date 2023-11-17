% Step 1: Define input and output variables
temperature = readfis('temperature.fis');
humidity = readfis('humidity.fis');
light_intensity = readfis('light_intensity.fis');
motion_level = readfis('motion_level.fis');

% Step 2: Provide input values and get the output
input_values = [75, 40, 200, 30]; % Example input values
output_temperature = evalfis(input_values, temperature);
output_humidity = evalfis(input_values, humidity);
output_light_intensity = evalfis(input_values, light_intensity);
output_motion_level = evalfis(input_values, motion_level);

% Step 3: Display the results
disp('Output temperature: ');
disp(output_temperature);

disp('Output humidity: ');
disp(output_humidity);

disp('Output light intensity:');
disp(output_light_intensity);

disp('Output motion level:');
disp(output_motion_level);

% Bar chart for the outputs
figure;

subplot(2, 2, 1);
bar(output_temperature);
title('Output Temperature');

subplot(2, 2, 2);
bar(output_humidity);
title('Output Humidity');

subplot(2, 2, 3);
bar(output_light_intensity);
title('Output Light Intensity');

subplot(2, 2, 4);
bar(output_motion_level);
title('Output Motion Level');
