function mean_correct_rate = get_mean_test_result(test_func, label_ind, ...
    num_iter, varargin)
    
    N = num_iter; % num of runs
    if nargin > 3
        TEMP_DIR = 'temp';
        input_dir = varargin{1};
    end
    
    correct_rate = [];
    
    progressbar;
    for i = 1:N
        if nargin > 3
            if exist(TEMP_DIR, 'dir')
                rmdir(TEMP_DIR, 's'); % remove subdirs
            end
            cmd_line = ['./gen_train_and_test_set.py ' input_dir ' ' TEMP_DIR];
            if nargin > 4
               cmd_line = [cmd_line ' "' varargin{2} '"'];
            end
            system(cmd_line);
        end
        correct_rate = [correct_rate; test_func(label_ind)];
        progressbar(i/N);
    end
    
    mean_correct_rate = mean(correct_rate, 1);
end