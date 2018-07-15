function entry = HRparticipants
% HRparticipants.m
%
% Select a control algorithm prepared by participants
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
student_list = [0:1:10];
entry = input('Choose entry number: 0 ? ');
if ( ismember(entry,student_list)==1 ),
	disp('Student Category ==========');
	switch entry,
		case 0,
			disp(sprintf(['Minato KOBE\n',...
					'     (ISTS Univ.)']));
	end
else
	disp('General Category ==========');
	switch entry,
		case 11,
			disp(sprintf(['Maya ROKKO\n',...
					'     (ISTS Co.)']));
	end
end
disp('Push any key to start .......');
pause
