function avatar=getprofile(avatar,opts)
% Generates profile per user


if ~isfield(opts,'domain')
    opts.domain = 'moodle.email';
end


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

ndpwd=12; % Digitos na senhas
symbs=[35:38 64];
vect = [symbs 48:57 64:90 97:122]; % from ascii table

oldchars={'á','é','í','ó','ú','ç','ã','õ'};
newchars={'a','e','i','o','u','c','a','o'};


for x=1:length(avatar)
    senha=[ vect(randperm(length(vect),ndpwd-1)) symbs(randperm(length(symbs),1)) ];
    avatar{x}.username = avatar{x}.id;
    avatar{x}.password = char(senha(randperm(length(senha))));
    avatar{x}.lastname = SobreNomes{randi(length(SobreNomes))};
    
    switch avatar{x}.opts.genero
        case 'F' % Feminino
            avatar{x}.firstname = NomesFemininos{randi(length(NomesFemininos))};
            
        case 'M' % Masculino
            avatar{x}.firstname = NomesMasculinos{randi(length(NomesMasculinos))};
    end
    
    strn = regexprep(lower([avatar{x}.firstname avatar{x}.lastname]),oldchars,newchars);
    avatar{x}.mailname = matlab.lang.makeValidName(strn,'ReplacementStyle','delete');
    avatar{x}.email = [avatar{x}.mailname '@' opts.domain];
    avatar{x}.city = Cidades{randi(length(Cidades))};
    avatar{x}.country = 'BR';
end


% username,password,firstname,lastname,email 'city','country',
