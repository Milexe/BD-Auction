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
    
        --Insert_Item('test final','please',21,Dat,1000,2,Cou);   --  создание item'a; имя, описание, продавец, дата до которой продается, начальная цена, аукцион(1 динамич.)

          --Actualize_Item(100128, cou); --перевод денег продавцу, если дата вышла: ид предмета
        --Updateprice(100128,42,Cou);-- обновление цены: ид предмета, ид покупателя
         --Delete_Item(100128, Cou); --удаление предмета: ид предмета
    --USER--     
         --Insert_User('final@roma.ru', 'final', Cou); --добавление аккаунта юзера: почта, пароль
        --Registration_User('final2@roma.ru','final',Cou); --регистрация: почта, пароль
         --Authorization_User('final2@roma.ru','final',cou); --авторизация юзера: почта, пароль
         --Addmoney(42, 5000);-- дать деняк: ид юзера, количество
       --Delete_User(100089,Cou); --удалить юзера: ид юзера
         --Exist_User('test2',ext);  --проверка существования юзера: почта
        --Get_Item('11111'); --получение предмета по совпадению в описании или названии
       --Get_Item_Category(2);-- получения списка предметов по заданной категории: ид категории
    --ITEMANDCATEGORY--
         --Insert_Itemandcategory(41,1); --добавление связи предмета с какой-то категорией: ид предмета, ид каегории
          
        --  Delete_Itemandcategory(41); --удаление связи предмета с категориями: ид предмета
    --AUCTION--
    --Fill_Auction(101,TRUNC(sysdate+4),3); --заполнение ДИНАМИЧЕСКОГО аукциона: ид, дата и категория данного аукциона
    --Get_Current(sysdate+4);--получить текущий предмет на динамическом аукционе
          --Insert_Auction(3, Trunc(Sysdate)+4, Cou); --добавить ДИНАМИЧЕСКИЙ аукцион: категория, дата проведения
          --Delete_Auction(101, Cou); --удалить аукцион: ид
          --CleanAuction(0,101); --убрать связи аукциона и предмета: ид предмета, ид аукциона. если ид предмета =0, то очищается аукцион, иначе связь предмета с аукционами
    --Alotiteminsert(100000,'hey',21);-- вставка множества предметов: количество, начало названия, ид продавца
    
    --Export_Users; --экспорт юзеров в файл c:/xmlFiles/users.txt
    --Import_Users;--импорт юзеров из файла c:/xmlFiles/users.txt
        --Encryptpassword(Text); хеширование: строка для хеширования
          dbms_output.put_line(cou);
    End;

    
    
    