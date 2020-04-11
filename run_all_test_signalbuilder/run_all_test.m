clear all;

%% 全テストモデルのファイルパスを取得
slx_path_all = {'TEST_sample.slx','TEST_sample2_NG.slx'}

%% i個目のテストモデルを実行
num_slx = length(slx_path_all);
for i=1:1:num_slx
    slx_path = slx_path_all{i};
    
    %% テストモデルの読み込み
    load_system(slx_path)
    
    %% 全ブロックのpathを抽出
    all_block_path = find_system()
    
    %% 'Builder'を含むブロックpathのindexを取得
    str_search_result = strfind(all_block_path, 'Builder');
    empty_cell = cellfun(@isempty, str_search_result);
    index_signal_builder = find(~empty_cell);
    
    %% Signal Builderのpathを取得
    path_signal_builder = all_block_path{index_signal_builder}
    
    %% Signal BuilderのGroup数を取得
    [time,data,signames,groupnames] = signalbuilder(path_signal_builder);
    num_group = length(groupnames);
    
    %% Group1からGroup num_groupまでシミュレーション実行
    
    for j=1:1:num_group
        signalbuilder(path_signal_builder, 'activegroup',j);
        sim(slx_path);
    end
    
end