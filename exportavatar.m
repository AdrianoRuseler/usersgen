function users=exportavatar(avatar,opts)

if ~isfield(opts,'site')
    opts.site = 'https://nupet.adrianoruseler.com';
end

if ~isfield(opts,'cohortnusr')
    opts.cohortnusr = 5; % Members per cohort
end

if ~isfield(opts,'filedir')
    opts.filedir = pwd; % Members per cohort
end



opts.cvsfile=[opts.filedir '\moodleimport.csv'];
opts.wikifile=[opts.filedir '\wikitable.txt'];
opts.keepassfile=[opts.filedir '\keepass.csv'];


header={'username','password','email','firstname','lastname','city','country','cohort1'};           
            
for x=1:length(avatar)
    users{x,1} = avatar{x}.username;
    users{x,2} = avatar{x}.password;
    users{x,3} = avatar{x}.email;   
    users{x,4} = avatar{x}.firstname; 
    users{x,5} = avatar{x}.lastname; 
    users{x,6} = avatar{x}.city; 
    users{x,7} = avatar{x}.country;
    users{x,8} = ['T' num2str(ceil(x/opts.cohortnusr),'%02i')];
end

Tusr = cell2table(users,'VariableNames',header);
writetable(Tusr,opts.cvsfile,'Delimiter',';','WriteRowNames',true,'Encoding','UTF-8')

%% Wiki


fileID = fopen(opts.wikifile,'w');
fprintf(fileID,'%s\n','{| class="wikitable sortable"');
fprintf(fileID,'%s\n','|-');
fprintf(fileID,'%s\n','! id !! username !! password !! email !! firstname !! lastname !! city !! country !! cohort1');

for a=1:length(users)
    fprintf(fileID,'%s\n','|-');    
    fprintf(fileID,'| %03d || %s || %s || %s || %s || %s || %s || %s || %s \n',a,users{a,1},users{a,2},users{a,3},users{a,4},users{a,5},users{a,6},users{a,7},users{a,8});        
end

fprintf(fileID,'%s\n','|}');
fclose(fileID);


%% KeePass
% "Account","Login Name","Password","Web Site","Comments"
% "Sample Entry Title","Greg","ycXfARD2G1AOBzLlhtbn","http://www.somepage.net","Some notes..."

fileID = fopen(opts.keepassfile,'w');
fprintf(fileID,'%s\n','"Account","Login Name","Password","Web Site","Comments"');

for a=1:length(users) 
    fprintf(fileID,'"%s","%s","%s","%s","%s" \n',[users{a,4} ' ' users{a,5}],users{a,1},users{a,2},opts.site,users{a,8});        
end

fclose(fileID);

