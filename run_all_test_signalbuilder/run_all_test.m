clear all;

%% �S�e�X�g���f���̃t�@�C���p�X���擾����
%% �e�X�g���f��slx���L�ڂ��ꂽcsv�t�@�C����ǂݍ���
filenames = readtable('filename_test_slx.csv','ReadVariableNames',true, 'Delimiter', ',');
%% i�ڂ̃e�X�g���f�������s
num_slx = length(filenames.Variables);
for i=1:1:num_slx
    filename_cell = filenames(i,'filename').Variables;
    filename = filename_cell{1};
    
    %% �e�X�g���f��slx��ǂݍ���
    load_system(filename)
    
    %% �S�u���b�N��path�𒊏o����
    all_block_path = find_system();
    
    %% 'Builder'���܂ރu���b�Npath��index���擾����
    str_search_result = strfind(all_block_path, 'Builder');
    empty_cell = cellfun(@isempty, str_search_result);
    index_signal_builder = find(~empty_cell);
    
    %% Signal Builder��path���擾����
    path_signal_builder = all_block_path{index_signal_builder};
    
    %% Signal Builder��Group�����擾����
    [time,data,signames,groupnames] = signalbuilder(path_signal_builder);
    num_group = length(groupnames);
    
    %% Group1����Group num_group�܂ŃV�~�����[�V�������s����
    
    for j=1:1:num_group
        signalbuilder(path_signal_builder, 'activegroup',j);
        sim(filename);
    end
    
end