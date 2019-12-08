function avatar=getavatar(opts)

% opts.genero = genero;
opts.format = 'png';
opts.width = '100'; % png only
opts.filedir = [pwd '\avatars'];

if ~exist(opts.filedir,'dir')
    mkdir(opts.filedir)
end


% https://getavataaars.com/
% npm install svgexport -g
% r = (b-a).*rand(1) + a;

% genero='F';  tmpName

switch opts.genero
    case 'F' % Feminino
        r1 = round(6*rand(1)+1); % F=1..7
        r2 = round(14*rand(1)+1); % F=1..15
        r3 = round(9*rand(1)+1); % F=1..10
        r4 = round(7*rand(1)+7); % F=8..15
        r5=1;
        r6 = 0; % F=1..8
        r7 = round(8*rand(1)+1); % F=1..9
        r8 = round(7*rand(1)+7); % F=8..15
        r9 = round(4*rand(1)+1); % F=1..5
        r10 = round(6*rand(1)+1); % F=1..7
        r11 = round(4*rand(1)+1); % F=1..5
        r12 = round(3*rand(1)+1); % F=1..4
        ids='f';
    case 'M' % Masculino
        r1 = round(4*rand(1)+3); % M=3..7
        r2 = round(11*rand(1)+16); % M=16..27
        r3 = round(7*rand(1)+1); % M=1..8
        r4 = round(7*rand(1)+1); % M=1..8
        r5 = round(5*rand(1)+1); % M=1..6
        r6 = r3; % round(7*rand(1)+1); % M=1..8
        r7 = round(8*rand(1)+1); % M=1..9
        r8 = round(7*rand(1)+1); % M=1..8
        r9 = round(4*rand(1)+1); % M=1..5
        r10 = round(6*rand(1)+1); % M=1..7
        r11 = round(4*rand(1)+1); % M=1..5
        r12 = round(3*rand(1)+1); % M=1..4
        ids='m';
    otherwise % Indefinido
        avatar=[];
        return
end
% 7
fir1 = fi(r1,0,3);
fir2 = fi(r2,0,5);
fir3 = fi(r3,0,4);
fir4 = fi(r4,0,4);
fir5 = fi(r5,0,4);
fir6 = fi(r6,0,4);
fir7 = fi(r7,0,4);
fir8 = fi(r8,0,4);
fir9 = fi(r9,0,3);
fir10 = fi(r10,0,3);
fir11 = fi(r11,0,3);
fir12 = fi(r12,0,3);

fix = fi(0,0,44,0);
fix.bin=[fir1.bin fir2.bin fir3.bin fir4.bin fir5.bin fir6.bin fir7.bin fir8.bin fir9.bin fir10.bin fir11.bin fir12.bin];
id=fix.hex;

% accessoriesType={'Kurt','Prescription01','Blank','Prescription02','Round','Sunglasses','Wayfarers'}; % 7
accessoriesType={'Blank','Kurt','Prescription01','Blank','Prescription02','Round','Blank'}; % 7
api.accessoriesType = accessoriesType{r1};

% topType={'NoHair','Eyepatch','Hat','Hijab','Turban','WinterHat1','WinterHat2','WinterHat3','WinterHat4','LongHairBigHair','LongHairBob','LongHairBun','LongHairCurly','LongHairCurvy','LongHairDreads','LongHairFrida',...
%     'LongHairFro','LongHairFroBand','LongHairNotTooLong','LongHairShavedSides','LongHairMiaWallace','LongHairStraight','LongHairStraigth2','LongHairStraightStrand','ShortHairDreads01','ShortHairDreads02','ShortHairFrizzle',...
%     'ShortHairShaggyMullet','ShortHairShortCurly','ShortHairShortFlat','ShortHairShortRound','ShortHairShortWaved','ShortHairSides','ShortHairTheCaesar','ShortHairTheCaesarSidePart'};
topType={'Hijab','LongHairBigHair','LongHairBob','LongHairBun','LongHairCurly','LongHairStraight2','LongHairFrida',...
    'LongHairFro','LongHairStraight2','LongHairNotTooLong','LongHairShavedSides','LongHairMiaWallace','LongHairStraight','LongHairStraight2','LongHairStraightStrand',...
    'Hat','Turban','ShortHairDreads01','Hat','ShortHairFrizzle',...
    'ShortHairShaggyMullet','ShortHairShortCurly','ShortHairShortFlat','ShortHairShortRound','ShortHairShortWaved','ShortHairSides','ShortHairTheCaesar'};
api.topType = topType{r2};

hairColor={'Auburn','Black','Blonde','BlondeGolden','Brown','BrownDark','Platinum','Red','SilverGray','PastelPink'};
hatColor={'Black','Blue01','Blue02','Blue03','Gray01','Gray02','Heather','Black','PastelBlue','PastelGreen','PastelOrange','PastelRed','PastelYellow','Pink','Red'};
api.hairColor = hairColor{r3};
api.hatColor = hatColor{r4};

facialHairType={'Blank','BeardMedium','BeardLigtht','BeardMagestic','MoustacheFancy','MoustacheMagnum'};
facialHairColor={'Auburn','Black','Blonde','BlondeGolden','Brown','BrownDark','Platinum','Red'};
api.facialHairType = facialHairType{r5};
if r6
    api.facialHairColor = facialHairColor{r6};
end

clotheType={'BlazerShirt','BlazerSweater','CollarSweater','GraphicShirt','Hoodie','Overall','ShirtCrewNeck','ShirtScoopNeck','ShirtVNeck'};
clotheColor={'Black','Blue01','Blue02','Blue03','Gray01','Gray02','Heather','Black','PastelBlue','PastelGreen','PastelOrange','PastelRed','PastelYellow','Pink','Red'};
api.clotheType = clotheType{r7};
api.clotheColor = clotheColor{r8};

% eyeType={'Close','Cry','Default','Dizzy','EyeRoll','Happy','Hearts','Side','Squint','Surprised','Wink','WinkWacky'};
% eyebrowType={'Angry','AngryNatural','Default','DefaultNatural','FlatNatural','RaisedExcited','RaisedExcitedNatural','SadConcerned','SadConcernedNatural','UnibrowNatural','UpDown','UpDownNatural'};
eyeType={'Default','Happy','Side','Squint','Wink'};
eyebrowType={'Default','DefaultNatural','FlatNatural','RaisedExcited','RaisedExcitedNatural','UnibrowNatural','UpDown'};
api.eyeType = eyeType{r9};
api.eyebrowType = eyebrowType{r10};


% mouthType={'Concerned','Default','Disbelief','Eating','Grimace','Sad','ScreamOpen','Serious','Smile','Tongue','Twinkle','Vomit'};
% skinColor={'Tanned','Yellow','Pale','Light','Brown','DarkBrown','Black'};
mouthType={'Default','Smile','Serious','Smile','Twinkle'};
skinColor={'Pale','Light','Brown','Black'};
api.mouthType = mouthType{r11};
api.skinColor = skinColor{r12};

options = weboptions('ContentType','text','Timeout',300);
% avatar.url='https://avataaars.io/?avatarStyle=Transparent&topType=LongHairBigHair&accessoriesType=Blank&hairColor=Auburn&facialHairType=BeardMagestic&facialHairColor=BlondeGolden&clotheType=ShirtCrewNeck&clotheColor=Pink&eyeType=Squint&eyebrowType=DefaultNatural&mouthType=Smile&skinColor=Pale';
% avatar.url='https://avataaars.io/png/100?hairColor=BrownDark&clotheType=Hoodie&avatarStyle=Circle'

switch opts.format
    case 'png'
        avatar.url=['https://avataaars.io/' opts.format '/' opts.width '?avatarStyle=Transparent'];
    case 'svg'
        avatar.url='https://avataaars.io/?avatarStyle=Transparent';
    otherwise % Indefinido
        avatar.url=['https://avataaars.io/' opts.format '/' opts.width '?avatarStyle=Transparent'];
end



fields=fieldnames(api);
for f=1:length(fields)
    avatar.url = [avatar.url '&' fields{f} '=' api.(fields{f}) ];
end

disp(['NEW AVATAR: ' avatar.url])
% accessoriesType={'Blank','Kurt','Prescription01','Prescription02','Round','Sunglasses','Wayfarers'};

avatar.id=[ids id];
avatar.opts=opts;

try
    tic
    switch opts.format
        case 'png'
            avatar.png = webread(avatar.url,options);
            avatar.file = [opts.filedir '\' avatar.id '.png'];
            fileID = fopen(avatar.file,'w');
            fprintf(fileID,'%s',avatar.png);
            fclose(fileID);
        case 'svg'
            avatar.svg = webread(avatar.url,options);
            avatar.file = [opts.filedir '\' avatar.id '.svg'];
            fileID = fopen(avatar.file,'w');
            fprintf(fileID,'%s',avatar.svg);
            fclose(fileID);
        otherwise % Indefinido
            avatar.file = [opts.filedir '\' avatar.id '.png'];
            fileID = fopen(avatar.file,'w');
            fprintf(fileID,'%s',avatar.png);
            fclose(fileID);
    end
    toc
catch ME
    disp(ME)
    avatar.error=ME;
    return
end

switch opts.format
    case 'png'
        fileID = fopen(avatar.file);
        tmpimg = fread(fileID);
        fclose(fileID);
        avatar.Base64 = char(org.apache.commons.codec.binary.Base64.encodeBase64(uint8(tmpimg)))';
    case 'svg'
        
    otherwise % Indefinido
end




