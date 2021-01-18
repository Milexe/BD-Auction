--------Users
Create Or Replace Procedure Insert_User(
    emailP          VARCHAR,
    Passwordp Varchar,
    resultId OUT INTEGER)
Is
  cou Int;
Begin
  Select Count(1) Into cou From Users Where email = emailp;
  IF cou    != 0 THEN
    resultId := -1;
  ELSE
    INSERT INTO Users
      (
        Email,
        Password
      )
      VALUES
      (
        emailP,
        Passwordp
      );
    resultId:=0;
  End If;
End;
/

Create Or Replace Procedure Authorization_user(
    emailP          VARCHAR,
    Passwordp Varchar,
    resultId OUT INTEGER)
Is
  Cou Int;
  Pw Varchar(255);
  text varchar(255);
Begin
  Select Count(1) Into cou From Users Where email = emailp;
  If Cou    != 0 Then
    Select Password Into Pw From Users Where Email=Emailp;
    text:=passwordp;
    Encryptpassword(text);
  if pw=text then
    Resultid:=0;
    Else
    resultId:=-1;
  End If;
  end if;
End;

Create Or Replace Procedure Registration_user(
    emailP          VARCHAR,
    Passwordp Varchar,
    resultId OUT INTEGER)
Is
  Cou Int;
  text varchar(255);
Begin
  if Regexp_Like (emailP, '[A-z0-9._%-]+@[A-z0-9._%-]+.[A-z]{2,4}')
   Then
    Resultid:=0;
    Text:=Passwordp;
    Encryptpassword(Text);
    Insert_User(emailp,text , resultId);
    Else
    resultId:=-1;
  end if;
End;

/

CREATE OR REPLACE PROCEDURE exist_user(
    emailP VARCHAR,
    resultId OUT BOOLEAN)
IS
  cou int;
Begin
  Select Count(1) Into Cou From Users Where email = Emailp;
  IF cou   != 0 THEN
    resultId:=true;
  ELSE
    resultId := false;
  End If;
END;

/


Create Or Replace Procedure Delete_User(--проверить каскадно
  idp int,
  Resultid Out int)
  Is
  cou int;
  Begin
  Select Count(1) Into Cou From Item Where Userid=Idp;
  If Cou = 0 Then
  Delete From Users Where Users.Id = Idp;
  resultId:=0;
  Else
  resultId:=-1;
  end if;
  End;
  
  /
  
  Create Or Replace Procedure Addmoney(
  Idp Int,
  Valuep Int)
  Is
  Begin
   Update Users
  Set money = money + valuep
  Where Id =Idp;
  end;
  / 
  --------Item
  /
  
  Create Or Replace Procedure Actualize_Item(
  Itemidp Int,
  resultId out int)
  Is
  Cou Int;
  Datep Date;
  Price Int;
  Begin
  Select Userid, Endtime, Currentprice Into Cou, Datep, Price From Item Where Id = Itemidp;
  If Datep < Trunc(Sysdate) And Price != 0 Then
  Update Users
  Set Money = Money + Price
  Where Id = cou;
  Update Item
  Set Currentprice = 0, endTime = TRUNC(sysdate-1)
  Where Id = Itemidp;
  Resultid:=0;
  
  Else
  Resultid:=-1;
  end if;
  end;
  
 
  
create or replace 
Procedure Get_Item(
text varchar
)
Is
    Cursor Cur Is Select id, Title, Description, Endtime, Startprice, Currentprice From Item Where
    ( Title Like '%' || Text || '%' Or Description Like '%' || Text || '%') And Typeid = 2;
        rec cur%rowtype;
    Begin
        for rec in cur
            Loop
            If(Cur%Rowcount<101) Then
            Dbms_Output.Put_Line(Cur%Rowcount||' '||Rec.id||' '||Rec.Title||' '||
                                 Rec.Description||' '||Rec.Endtime|| ' '||
                                 Rec.Startprice||' '||Rec.Currentprice);
                                 Else Exit;
                                 End If;
                                 
            End Loop;
        --close cur;
    end;

Create Or Replace 
Procedure Get_Item_Category(
typ int
)
Is
    Cursor Cur Is Select item.id, Item.Title, Item.Description, Item.Endtime, Item.Startprice,  Item.Currentprice, Category.Title cat_title From Item Join Itemandcategory Iac On Item.Id = Iac.Itemid Join Category On Iac.Categoryid = Category.Id Where
    category.id = typ And Typeid = 2;
        rec cur%rowtype;
    Begin
        for rec in cur
            Loop
            If(Cur%Rowcount<101) Then
            Dbms_Output.Put_Line(Cur%Rowcount||' '||Rec.id||' '||Rec.Title||' '||
                                 Rec.Description||' '||Rec.Endtime|| ' '||
                                 Rec.Startprice||' '||Rec.Currentprice||' '||Rec.Cat_Title);
                                 else exit;
                                 end if;
            End Loop;
        --close cur;
    end;



Create Or Replace Procedure Insert_Item(
    Titlep Varchar,
	Descriptionp Varchar,
	Useridp Int,
	Endtimep Date,
	Startpricep Int,
	Typeidp Int,
   Resultid Out Integer)
IS
  cou Int;
Begin
  Select Count(1) Into Cou From Auctiontype Where Id = Typeidp;
  IF (cou  = 0) or (startPricep <=0) THEN
    resultId := -1;
  Else
    INSERT INTO Item
      (
        Title,
      	Description,
      	Userid,
      	endTime,
      	Startprice,
      	typeId
      )
      VALUES
      (
        Titlep,
        Descriptionp,
      	Useridp,
      	Endtimep,
      	Startpricep,
      	Typeidp
      );
    resultId:=0;
  End If;
End;





Create Or Replace Procedure Updateprice(
    idp int,
	Buyeridp Int,
   Resultid Out Integer)
IS
  Cou Int;
  Perc Int;
  couBefore int;
  bId Int;
  Sid Int;
  Mon Int;
  dat date;
Begin
  Select Currentprice, Startprice,Userid, Buyerid, Currentprice, Endtime Into Cou, Perc, Sid, Bid, Coubefore, dat  From Item Where Id = Idp;
  Select Money Into Mon From Users Where Id=buyerIdp;
  
  If ((Cou >= (Perc*0.1)*25) or (sId = idp) or (bId=buyeridp)or(mon<cou) or (mon<Perc) or (dat<TRUNC(sysdate)))
  Then
  Resultid := -1;
  Else
  If Cou = 0
  Then Cou := Perc;
  Else Cou := Cou+(Perc*0.1); 
  End If;
    Update Users
  Set Money = Money - Cou
  where id=buyerIdp;
    Update Users
  Set Money = Money + Coubefore
  where id=bId;
   Update Item
  Set Buyerid = Buyeridp,
  currentPrice = Cou
  Where Id =Idp;

    resultId:=0;
  end if;
End;

create or replace 
Procedure Delete_Item(
Idp Int,
resultId out int)
Is
  Cou Int;
  bid int;
Begin

Select Count(1) Into Cou From Item Where Id = Idp;
If Cou = 0 
Then
Resultid:=-1;
Else
Select Currentprice Into Bid From Item Where Id = Idp;
If Bid != 0
Then
Resultid:=-1;
Else
Select Typeid Into Bid From Item Where Id = Idp;
if bId = 1 then
Cleanauction(Idp, 0);
end if;
Delete_Itemandcategory(idp);
  Delete From Item Where Id=Idp;
  resultId:=0;
  End If;
  end if;
End;
/
--ItemAndCategory
/
Create Or Replace Procedure Insert_Itemandcategory(
Itemidp Int,
Categoryidp Int)
Is
Begin
INSERT INTO ItemAndCategory
      (
        Itemid,
        categoryId
      )
      VALUES
      (
        Itemidp,
        categoryIdp
        );
  end;
  
  
  Create Or Replace Procedure Delete_Itemandcategory(
Itemidp Int)
Is
Begin
Delete From ItemAndCategory Where Itemid=Itemidp;
  end;
  /
  --auction
  /
  Create Or Replace Procedure Insert_Auction(
Categoryidp Int,
Startdatep Date,
resultId out int)
Is
cou int;
Begin
Select count(1) Into Cou From Auction Where Startdate = Startdatep;
If Startdatep > Sysdate and cou=0 Then
INSERT INTO Auction
      (
        Categoryid,
        startDate
      )
      VALUES
      (
        Categoryidp,
        startDatep
        );
        resultId := 0;
        Else
      Resultid:=-1;
      end if;
  end;
  
  Create Or Replace Procedure Delete_Auction(
Idp Int,
resultId out int)
Is
  Cou Date;
  tes date := TRUNC(sysdate);
  bid int;
Begin
Select Count(1) Into Bid From Auction Where Id = Idp;
If Bid=0 Then
Resultid:=-1;
else
Select Startdate Into Cou From Auction Where Id = Idp;
If cou <= tes
Then
Resultid:=-1;
Else
CleanAuction(0, idP);
  Delete From Auction Where Id=Idp;
  resultId:=0;
  End If;
  End If;
End;

/
--itemsAndAuction
/
Create Or Replace Procedure Insert_Itemsandauction(
Itemidp Int,
Auctionidp Int,
num int)
Is
cou int;
Begin
Select Count(1) Into Cou From Itemsandauction Where Auctionid=Auctionidp And Count=Num;
If Cou=0 Then
Select Count(1) Into Cou From Itemsandauction Where Itemid = Itemidp;
if cou=0 then
INSERT INTO ItemsAndAuction
      (
        Itemid,
        Auctionid,
        count
      )
      VALUES
      (
        Itemidp,
        Auctionidp,
        Num);
        End If;
        end if;
  End;
  
  
  Create Or Replace Procedure Get_Current(
  Datet date
  )
  Is
  Cursor Cur Is Select Item.Title, Item.Description, Item.Endtime, Item.Startprice, Item.currentPrice From Item join ItemsAndAuction on item.id = ItemsAndAuction.itemId join Auction on ItemsAndAuction.auctionId = Auction.id Where (Itemsandauction.Count = Round(To_Number(To_Char(Datet, 'HH24'))/2 + 0.9)) and Auction.startDate = (TRUNC(datet)) ;
        rec cur%rowtype;
    Begin
        for rec in cur
            loop
            Dbms_Output.Put_Line(Cur%Rowcount||' '||Rec.Title||' '||
                                 Rec.Description||' '||Rec.Endtime|| ' '||
                                 Rec.Startprice||' '||rec.currentPrice);
            End Loop;
           
  end;
  
  
  
create or replace 
Procedure CleanAuction(
Itemidp Int,
auctionIdp int)
Is
Dat Date;
Tes Date := Trunc(Sysdate);
cou int;
Begin
If Itemidp=0 Then
Select Startdate Into Dat From Auction Where id=Auctionidp;
If Dat != Tes Then
Delete From Itemsandauction Where Auctionid=Auctionidp;
End If;
Else
Select Count(1) Into Cou From Auction Inner Join Itemsandauction On Id=Itemsandauction.Auctionid And Itemsandauction.Itemid=Itemidp;
If Cou=0 Then
Cou:=0;
else
Select Auction.Startdate Into Dat From Auction Inner Join Itemsandauction On Id=Itemsandauction.Auctionid And Itemsandauction.Itemid=Itemidp;
If Dat != Tes Then

Delete From Itemsandauction Where Itemid=Itemidp;
end if;
  End If;
  End If;
End;


 Create Or Replace Procedure Fill_Auction(
 Auctionidp Int,
 Cou Date,
 cat int)
 Is
  Cursor Cur Is  Select Item.Id From Item Left Outer Join Itemsandauction On Item.Id = Itemsandauction.Itemid Join Itemandcategory On Item.Id = Itemandcategory.Itemid
  Where Typeid=1 And Endtime>=Cou and categoryId=cat and CurrentPrice=0;

      rec cur%rowtype;
      I Int:=1;
 Begin

  Open Cur;
      Fetch Cur Into rec;
      while(cur%found and i != 13)
      Loop
         Insert_Itemsandauction(rec.id,auctionIdP,i);
          Fetch Cur Into rec;
          i:=i+1;
      End Loop;
      close cur;
 end;
 
 
 
 create or replace procedure encryptPassword (casualPassword in out varchar2) is
  l_key varchar2(2000) := '1234567890123456';
  l_mod NUMBER  :=DBMS_CRYPTO.encrypt_aes128
                    + DBMS_CRYPTO.chain_cbc
                    + DBMS_CRYPTO.pad_pkcs5;
  newPassword RAW(2000);
begin
  newPassword:= DBMS_CRYPTO.encrypt (utl_i18n.string_to_raw (casualPassword, 'AL32UTF8'),
                                      l_mod,
                                      utl_i18n.string_to_raw (l_key, 'AL32UTF8')
  );
  casualPassword := newPassword;
End;

 
 
 --XML--
  CREATE OR REPLACE DIRECTORY EXPORTFILE
As
  'C:\\xmlFiles';
  
  
  
 CREATE OR REPLACE PROCEDURE export_users
IS
  file1 utl_file.file_type;
  xrow CLOB;
Begin
  file1 := UTL_FILE.FOPEN('EXPORTFILE','users.txt','w');
  SELECT XMLELEMENT(root,XMLAGG(XMLELEMENT(appuser, 
      XMLATTRIBUTES(
          E.Id,
          e.email,
          e.password,
          e.Money)
        ))).getCLOBVal() AS xmlsads
    Into Xrow
    FROM Users e;
  utl_file.put(file1,xrow);
  utl_file.fclose(file1);
END;


 CREATE OR REPLACE PROCEDURE import_users
IS
  file1 utl_file.file_type;
  xrow CLOB;
BEGIN
  file1 := UTL_FILE.FOPEN('EXPORTFILE','users.txt','r');
  utl_file.get_line(file1,xrow);
  merge INTO Users cur_t USING
  (Select Extractvalue(Value(T),'//@ID') Id,
    extractValue(value(t),'//@EMAIL') email,
    Extractvalue(Value(T),'//@PASSWORD') Password,
    extractValue(value(t),'//@MONEY') Money
  FROM TABLE(XMLSequence(XMLType(xrow).extract('//APPUSER'))) t
  ) imp_t ON (cur_t.id=imp_t.id)
WHEN NOT matched THEN
  INSERT
    (
      Cur_T.Id,
      Cur_T.Email,
      cur_t.password,
      cur_t.Money
    )
    VALUES
    (
      imp_t.id,
      Imp_T.Email,
      Imp_T.Password,
      imp_t.Money
    );
  Utl_File.Fclose(File1);
End;
