Insert Into Auctiontype
(Title)
Values 
('Dynamic');
Insert Into Auctiontype
(Title)
Values 
('Static');
Insert Into Category
(Title)
Values 
('Cars');
Insert Into Category
(Title)
Values 
('Tech');
Insert Into Category
(Title)
Values 
('art');
Insert Into Category
(Title)
Values 
('Other');
Insert Into Category
(Title)
Values 
('Clothes');

Create Or Replace Procedure Alotiteminsert(coun int, strin varchar, userId int)
Is
I Int:=10;
cou int;
Begin
While(I<coun)
Loop
Insert_Item(Strin||I,'rand descr'||I, Userid, To_Date('20210101', 'YYYYMMDD'),I*10,Mod(I,2)+1,Cou); 
Select Id Into Cou From Item Where Title = Strin||I;
Insert_Itemandcategory(cou, mod(i, 5)+1);
i:=i+1;
End Loop;
end;


