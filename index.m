%% M
opts.genero = 'M';
opts.format = 'png';
opts.width = '100'; % png only
opts.filedir = [pwd '\avatarsM'];

for x=1:125
    disp(x)
    avatar{x}=getavatar(opts);
    if isfield(avatar{x},'error')
        disp('Error!!')
        x=x-1;
    end
end

opts.domain = 'moodle.email';
avatar=getprofile(avatar,opts);

opts.site = 'https://nupet.adrianoruseler.com';
opts.cohortnusr = 5; % Members per cohort
users=exportavatar(avatar,opts);

save([opts.filedir '\' date '.mat'],'avatar','opts','users')

% avatar=getavatar('F');
% imshow(avatar.img)



%% F

opts.genero = 'F';
opts.format = 'png';
opts.width = '100'; % png only
opts.filedir = [pwd '\avatarsF'];

for x=1:125
    disp(x)
    avatar{x}=getavatar(opts);
    if isfield(avatar{x},'error')
        disp('Error!!')
        x=x-1;
    end
end

opts.domain = 'moodle.email';
avatar=getprofile(avatar,opts);

opts.site = 'https://nupet.adrianoruseler.com';
opts.cohortnusr = 5; % Members per cohort
users=exportavatar(avatar,opts);

save([opts.filedir '\' date '.mat'],'avatar','opts','users')

% avatar=getavatar('F');
% imshow(avatar.img)
