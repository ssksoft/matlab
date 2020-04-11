clear all;

%% �S�e�X�g���f���̃t�@�C���p�X���擾
slx_path_all = {'TEST_sample.slx','TEST_sample2_NG.slx'}

%% i�ڂ̃e�X�g���f�������s
num_slx = length(slx_path_all);
for i=1:1:num_slx
    slx_path = slx_path_all{i};
    
    %% �e�X�g���f���̓ǂݍ���
    load_system(slx_path)
    
    %% �S�u���b�N��path�𒊏o
    all_block_path = find_system()
    
    %% 'Builder'���܂ރu���b�Npath��index���擾
    str_search_result = strfind(all_block_path, 'Builder');
    empty_cell = cellfun(@isempty, str_search_result);
    index_signal_builder = find(~empty_cell);
    
    %% Signal Builder��path���擾
    path_signal_builder = all_block_path{index_signal_builder}
    
    %% Signal Builder��Group�����擾
    [time,data,signames,groupnames] = signalbuilder(path_signal_builder);
    num_group = length(groupnames);
    
    %% Group1����Group num_group�܂ŃV�~�����[�V�������s
    
    for j=1:1:num_group
        signalbuilder(path_signal_builder, 'activegroup',j);
        sim(slx_path);
    end
    
end