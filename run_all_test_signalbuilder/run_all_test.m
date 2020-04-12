clear all;

msg_create_report = '���ׂẴe�X�g�P�[�X�ɍ��i�����e�X�g���f��slx�t�@�C�������o�͂��܂��B';

%% �S�e�X�g���f���̃t�@�C���p�X���擾����
%% �e�X�g���f��slx���L�ڂ��ꂽcsv�t�@�C����ǂݍ���
filenames = readtable('filename_test_slx.csv','ReadVariableNames',true, 'Delimiter', ',');
%% i�ڂ̃e�X�g���f�������s
num_slx = length(filenames.Variables);
pass = 1;
for i=1:1:num_slx
    filename_cell = filenames(i,'filename').Variables;
    filename_extension = filename_cell{1};
    filename = erase(filename_extension, '.slx');
    
    %% �e�X�g���f��slx��ǂݍ���
    load_system(filename)
    
    %% �S�u���b�N��path�𒊏o����
    all_block_path = find_system(filename);
    
    %% 'Builder'���܂ރu���b�Npath��index���擾����
    str_search_result = strfind(all_block_path, 'Builder');
    empty_cell = cellfun(@isempty, str_search_result);
    index_signal_builder = find(~empty_cell);
    
    %% Signal Builder�u���b�N��2�ȏ㑶�݂���ꍇ�A�e�X�g�s���i�Ƃ���
    num_signalbuilder = length(index_signal_builder);
    if num_signalbuilder > 1
        continue;
    end
    
    %% Signal Builder��path���擾����
    path_signal_builder = all_block_path{index_signal_builder};
    
    %% Signal Builder��Group�����擾����
    [time,data,signames,groupnames] = signalbuilder(path_signal_builder);
    num_group = length(groupnames);
    
    %% Group1����Group num_group�܂ŃV�~�����[�V�������s����
    %% �V�~�����[�V�������s
    try
        for j=1:1:num_group
            signalbuilder(path_signal_builder, 'activegroup',j);
            sim(filename); 
        end   
        %% �e�X�g���i�t�@�C������ǉ�
            filename_pass{pass} = filename;
            pass = pass+1;
    catch ME
        % �e�X�g���i�t�@�C�����ւ̒ǉ������Ȃ�
        % assertion�G���[���b�Z�[�W�̕\��
        disp(ME.message)
    end
    close_system(filename,0)
end
disp(msg_create_report)

%% �e�X�g���|�[�g����
report_contents_header = {'filename'};
report_contents_filename = filename_pass;
report_contents = {report_contents_header{1},report_contents_filename{1:end}}'
writecell(report_contents,'test_result.csv');
