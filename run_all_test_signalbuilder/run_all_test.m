clear all;

%% 全テストモデルのファイルパスを取得する
%% テストモデルslxが記載されたcsvファイルを読み込む
filenames = readtable('filename_test_slx.csv','ReadVariableNames',true, 'Delimiter', ',');
%% i個目のテストモデルを実行
num_slx = length(filenames.Variables);
for i=1:1:num_slx
    filename_cell = filenames(i,'filename').Variables;
    filename = filename_cell{1};
    
    %% テストモデルslxを読み込む
    load_system(filename)
    
    %% 全ブロックのpathを抽出する
    all_block_path = find_system();
    
    %% 'Builder'を含むブロックpathのindexを取得する
    str_search_result = strfind(all_block_path, 'Builder');
    empty_cell = cellfun(@isempty, str_search_result);
    index_signal_builder = find(~empty_cell);
    
    %% Signal Builderのpathを取得する
    path_signal_builder = all_block_path{index_signal_builder};
    
    %% Signal BuilderのGroup数を取得する
    [time,data,signames,groupnames] = signalbuilder(path_signal_builder);
    num_group = length(groupnames);
    
    %% Group1からGroup num_groupまでシミュレーション実行する
    
    for j=1:1:num_group
        signalbuilder(path_signal_builder, 'activegroup',j);
        sim(filename);
    end
    
end