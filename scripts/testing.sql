Select * From Users;
Select * From Auctiontype;
Select * From Item;
Select * From Itemandcategory;
Select * From Category;
Select * From Auction;
Select * From Itemsandauction;

/
----items
/
Declare
Cou Int:=-2; 
ext boolean;
Text Varchar(255):='test3';
dat Date := TO_DATE('20201228', 'YYYYMMDD');
    Begin
    --ITEM TEST--
    
        --Insert_Item('test final','please',21,Dat,1000,2,Cou);   --  �������� item'a; ���, ��������, ��������, ���� �� ������� ���������, ��������� ����, �������(1 �������.)

          --Actualize_Item(100128, cou); --������� ����� ��������, ���� ���� �����: �� ��������
        --Updateprice(100128,42,Cou);-- ���������� ����: �� ��������, �� ����������
         --Delete_Item(100128, Cou); --�������� ��������: �� ��������
    --USER--     
         --Insert_User('final@roma.ru', 'final', Cou); --���������� �������� �����: �����, ������
        --Registration_User('final2@roma.ru','final',Cou); --�����������: �����, ������
         --Authorization_User('final2@roma.ru','final',cou); --����������� �����: �����, ������
         --Addmoney(42, 5000);-- ���� �����: �� �����, ����������
       --Delete_User(100089,Cou); --������� �����: �� �����
         --Exist_User('test2',ext);  --�������� ������������� �����: �����
        --Get_Item('11111'); --��������� �������� �� ���������� � �������� ��� ��������
       --Get_Item_Category(2);-- ��������� ������ ��������� �� �������� ���������: �� ���������
    --ITEMANDCATEGORY--
         --Insert_Itemandcategory(41,1); --���������� ����� �������� � �����-�� ����������: �� ��������, �� ��������
          
        --  Delete_Itemandcategory(41); --�������� ����� �������� � �����������: �� ��������
    --AUCTION--
    --Fill_Auction(101,TRUNC(sysdate+4),3); --���������� ������������� ��������: ��, ���� � ��������� ������� ��������
    --Get_Current(sysdate+4);--�������� ������� ������� �� ������������ ��������
          --Insert_Auction(3, Trunc(Sysdate)+4, Cou); --�������� ������������ �������: ���������, ���� ����������
          --Delete_Auction(101, Cou); --������� �������: ��
          --CleanAuction(0,101); --������ ����� �������� � ��������: �� ��������, �� ��������. ���� �� �������� =0, �� ��������� �������, ����� ����� �������� � ����������
    --Alotiteminsert(100000,'hey',21);-- ������� ��������� ���������: ����������, ������ ��������, �� ��������
    
    --Export_Users; --������� ������ � ���� c:/xmlFiles/users.txt
    --Import_Users;--������ ������ �� ����� c:/xmlFiles/users.txt
        --Encryptpassword(Text); �����������: ������ ��� �����������
          dbms_output.put_line(cou);
    End;

    
    
    