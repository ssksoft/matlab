clear all;

%% �e�X�g���f���̃t�@�C���p�X���擾
slx_path = 'TEST_sample.slx';

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

%% Group1����Group n�܂ŃV�~�����[�V�������s

for i=1:1:num_group
    signalbuilder(path_signal_builder, 'activegroup',i);
    sim(slx_path);
end