clear all;

msg_create_report = 'すべてのテストケースに合格したテストモデルslxファイル名を出力します。';

%% 全テストモデルのファイルパスを取得する
%% テストモデルslxが記載されたcsvファイルを読み込む
filenames = readtable('filename_test_slx.csv','ReadVariableNames',true, 'Delimiter', ',');
%% i個目のテストモデルを実行
num_slx = length(filenames.Variables);
pass = 1;
for i=1:1:num_slx
    filename_cell = filenames(i,'filename').Variables;
    filename_extension = filename_cell{1};
    filename = erase(filename_extension, '.slx');
    
    %% テストモデルslxを読み込む
    load_system(filename)
    
    %% 全ブロックのpathを抽出する
    all_block_path = find_system(filename);
    
    %% 'Builder'を含むブロックpathのindexを取得する
    str_search_result = strfind(all_block_path, 'Builder');
    empty_cell = cellfun(@isempty, str_search_result);
    index_signal_builder = find(~empty_cell);
    
    %% Signal Builderブロックが2つ以上存在する場合、テスト不合格とする
    num_signalbuilder = length(index_signal_builder);
    if num_signalbuilder > 1
        continue;
    end
    
    %% Signal Builderのpathを取得する
    path_signal_builder = all_block_path{index_signal_builder};
    
    %% Signal BuilderのGroup数を取得する
    [time,data,signames,groupnames] = signalbuilder(path_signal_builder);
    num_group = length(groupnames);
    
    %% Group1からGroup num_groupまでシミュレーション実行する
    %% シミュレーション実行
    try
        for j=1:1:num_group
            signalbuilder(path_signal_builder, 'activegroup',j);
            sim(filename); 
        end   
        %% テスト合格ファイル名を追加
            filename_pass{pass} = filename;
            pass = pass+1;
    catch ME
        % テスト合格ファイル名への追加をしない
        % assertionエラーメッセージの表示
        disp(ME.message)
    end
    close_system(filename,0)
end
disp(msg_create_report)

%% テストレポート生成
report_contents_header = {'filename'};
report_contents_filename = filename_pass;
report_contents = {report_contents_header{1},report_contents_filename{1:end}}'
writecell(report_contents,'test_result.csv');
