files = dir('*.gray');
for i = 1:length(files)
    display(files(i).name);
	oldname = regexp(files(i).name,'\.','split');
    oldname = char(oldname{1});
	newname = strcat(oldname,'.gray.png');
    oldname = files(i).name;
	eval(['!rename' 32 oldname 32 newname]);
end