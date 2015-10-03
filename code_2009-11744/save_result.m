function [] = save_result(results)
  output = n_of_max(results);
  fp = fopen('result.txt', 'w');
  fprintf(fp, '%2d', output);
  fclose(fp);
end
