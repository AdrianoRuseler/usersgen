% clear api avatar

opts.genero = 'M';
% opts.format = 'png';
% opts.width = '100'; % png only
% opts.filedir = [pwd '\avatars'];

for x=1:10
    disp(x)
    avatar{x}=getavatar(opts);
    if isfield(avatar{x},'error')
        disp('Error!!')
        x=x-1;
    end
end

% avatar=getavatar('F');
% imshow(avatar.img)

%% Load Names Surnames and Cities

% opts = detectImportOptions('Nomes.xls')
Tsn = readtable('SobreNomes.csv','ReadVariableNames',false);
Csn = table2cell(Tsn);
SobreNomes=Csn(~cellfun('isempty',Csn));

% NomesFemininos.csv
Tnf = readtable('NomesFemininos.csv','ReadVariableNames',false);
Cnf = table2cell(Tnf);
NomesFemininos=Cnf(~cellfun('isempty',Cnf));

% NomesMasculinos
Tnm = readtable('NomesMasculinos.csv','ReadVariableNames',false);
Cnm = table2cell(Tnm);
NomesMasculinos=Cnm(~cellfun('isempty',Cnm));

Tcd = readtable('Cidades.csv','ReadVariableNames',false,'Encoding','UTF-8');
Cidades = table2cell(Tcd);

% nf=NomesFemininos{randi(length(NomesFemininos))};
% nm=NomesMasculinos{randi(length(NomesMasculinos))};
% sn=SobreNomes{randi(length(SobreNomes))};
%
% ncm=[nm ' ' sn];
% ncf=[nf ' ' sn];

% figfiles=ls('*.png'); % Gets png files


for x=1:length(avatar)
    tmp{x} = figfiles(x,2:end-4);
    
    
    
    
end






%%
% username,password,firstname,lastname,email,course1,cohort1
header={'username','password','email','firstname','lastname','city','country','cohort1'};

for x=1:length(figfiles)
    tmp{x} = figfiles(x,2:end-4);
end

nalunos=250; % Numero de alunos
idx={tmp{randperm(length(tmp),nalunos)}};

mkdir avatars

nalunospturma = 10; % Alunos por turma

% genero='F';
ndpwd=12; % Digitos na senhas
symbs=[35:38 64];
vect = [symbs 48:57 64:90 97:122]; % from ascii table

oldchars={'á','é','í','ó','ú','ç','ã','õ'};
newchars={'a','e','i','o','u','c','a','o'};

switch genero
    case 'F' % Feminino
        for x=1:length(idx)
            users{x,1} = ['f' idx{x}];
            senha=[ vect(randperm(length(vect),ndpwd-1)) symbs(randperm(length(symbs),1)) ];
            users{x,2} = char(senha(randperm(length(senha))));
            
            users{x,4} = NomesFemininos{randi(length(NomesFemininos))};
            users{x,5} = SobreNomes{randi(length(SobreNomes))};
            strn = regexprep(lower([users{x,4} users{x,5}]),oldchars,newchars);
            mailname = matlab.lang.makeValidName(strn,'ReplacementStyle','delete');
            users{x,3} = [mailname '@moodle.lan'];
            users{x,6} = Cidades{randi(length(Cidades))};
            users{x,7} = 'BR';
            users{x,8} = ['T' num2str(ceil(x/nalunospturma),'%02i')];
            copyfile(['f' idx{x} '.png'],['avatars/f' idx{x} '.png']) % Copia arquivo
        end
        Tusr = cell2table(users,'VariableNames',header);
        writetable(Tusr,'avatars/FUsers.csv','Delimiter',';','WriteRowNames',true,'Encoding','UTF-8')
        
    case 'M' % Masculino
        for x=1:length(idx)
            users{x,1} = ['m' idx{x}];
            senha=[ vect(randperm(length(vect),ndpwd-1)) symbs(randperm(length(symbs),1)) ];
            users{x,2} = char(senha(randperm(length(senha))));
            users{x,4} = NomesMasculinos{randi(length(NomesMasculinos))};
            users{x,5} = SobreNomes{randi(length(SobreNomes))};
            strn = regexprep(lower([users{x,4} users{x,5}]),oldchars,newchars);
            mailname = matlab.lang.makeValidName(strn,'ReplacementStyle','delete');
            users{x,3} = [mailname '@moodle.lan'];
            users{x,6} = Cidades{randi(length(Cidades))};
            users{x,7} = 'BR';
            users{x,8} = ['T' num2str(ceil(x/nalunospturma),'%02i')];
            copyfile(['m' idx{x} '.png'],['avatars/m' idx{x} '.png']) % Copia arquivo
        end
        Tusr = cell2table(users,'VariableNames',header);
        writetable(Tusr,'avatars/MUsers.csv','Delimiter',';','WriteRowNames',true,'Encoding','UTF-8')        
end

fileID = fopen('Users-wikitable.txt','w');
fprintf(fileID,'%s\n','{| class="wikitable sortable"');
fprintf(fileID,'%s\n','|-');
fprintf(fileID,'%s\n','! id !! username !! password !! email !! firstname !! lastname !! city !! country !! cohort1');

for a=1:length(users)
    fprintf(fileID,'%s\n','|-');    
    fprintf(fileID,'| %03d || %s || %s || %s || %s || %s || %s || %s || %s \n',a,users{a,1},users{a,2},users{a,3},users{a,4},users{a,5},users{a,6},users{a,7},users{a,8});        
end

fprintf(fileID,'%s\n','|}');
fclose(fileID);


winopen('Users-wikitable.txt')

%%

fileID = fopen(['Erro-wikitable.txt'],'w');
fprintf(fileID,'%s\n','{| class="wikitable sortable"');
fprintf(fileID,'%s\n','|-');
fprintf(fileID,'%s\n','! ID !! uid !! Nome !! Curso !! situacao !! pesscodnr !! curscodnr');

e=1;
for a=1:length(alunos.codigo)
    if isfield(alunos.hist{a},'rawdata')
        if contains(alunos.hist{a}.rawdata,'Problemas para recuperar os dados do aluno')
            disp(alunos.hist{a}.url)
            erro.uid{e}=alunos.uid{a};
            erro.url{e}=alunos.hist{a}.url;
            
            fprintf(fileID,'%s\n','|-');
            fprintf(fileID,'| %03d || [%s %s] || %s || %s || %s || %s || %s \n',e,alunos.hist{a}.url,...
                alunos.uid{a},alunos.nome{a},alunos.curso{a},alunos.situacao{a},alunos.pesscodnr{a},alunos.curscodnr{a});
            
            e=e+1;
        end
    else
        
    end
    %     if isfield(alunos.hist{a},'foto')
    %         alunos.hist{a} = rmfield(alunos.hist{a},'foto');
    %     end
    
    %     if isfield(alunos.hist{a},'fotoBase64')
    %         alunos.hist{a} = rmfield(alunos.hist{a},'fotoBase64');
    %     end
end

fprintf(fileID,'%s\n','|}');
fclose(fileID);

winopen(['Erro-wikitable.txt'])




