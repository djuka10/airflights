INSERT INTO abstract_user(id, address, email, first_name, index_number,last_name, password ,phone_number,verify,id_company,marked)
VALUES (1, 'Beocin', 'nemanja@gmail.com', 'Nemanja', '345345','Dimsic','$2a$04$Vbug2lwwJGrvUXTj6z7ff.97IzVBkrJ1XfApfGNl.Z695zqcnPYra','4535',true,0,false);
INSERT INTO abstract_user(id, address, email, first_name, index_number,last_name, password ,phone_number, verify,id_company,marked)
VALUES (2, 'Sremska Kamenica', 'sveta@gmail.com', 'Svetislav', '2222','Simic','$2a$04$Vbug2lwwJGrvUXTj6z7ff.97IzVBkrJ1XfApfGNl.Z695zqcnPYra','43537', true,3,false);
INSERT INTO abstract_user(id, address, email, first_name, index_number,last_name, password ,phone_number, verify,id_company,marked)
VALUES (3, 'Klisa', 'dule@gmail.com', 'Dusan', '867867','Svilarkovic','$2a$04$Vbug2lwwJGrvUXTj6z7ff.97IzVBkrJ1XfApfGNl.Z695zqcnPYra','4353', true,1,false);
INSERT INTO abstract_user(id, address, email, first_name, index_number,last_name, password ,phone_number, verify,id_company,marked)
VALUES (4, 'Subotica', 'pero@gmail.com', 'Pera', '867867','Peric','$2a$04$Vbug2lwwJGrvUXTj6z7ff.97IzVBkrJ1XfApfGNl.Z695zqcnPYra','4353', false, 0,false);
INSERT INTO abstract_user(id, address, email, first_name, index_number,last_name, password ,phone_number, verify,id_company,marked)
VALUES (5, 'Beocin', 'viktor@gmail.com', 'Viktor', '65986','Djuka','$2a$04$Vbug2lwwJGrvUXTj6z7ff.97IzVBkrJ1XfApfGNl.Z695zqcnPYra','66566', true,2,false);


INSERT INTO roles(name) VALUES('ROLE_USER');
INSERT INTO roles(name) VALUES('ROLE_SYSTEMADMIN');
INSERT INTO roles(name) VALUES('ROLE_AIRFLIGHTADMIN');
INSERT INTO roles(name) VALUES('ROLE_HOTELADMIN');
INSERT INTO roles(name) VALUES('ROLE_RENTACARADMIN');

INSERT INTO user_roles(user_id, role_id) VALUES(1,2);
INSERT INTO user_roles(user_id, role_id) VALUES(2,4);
INSERT INTO user_roles(user_id, role_id) VALUES(3,3);
INSERT INTO user_roles(user_id, role_id) VALUES(5,5);

INSERT INTO rentacar(id, address, city, description, name, rating)
VALUES (1, 'Bulevar oslobođenja 13/1',' Novi Sad', 'aksjfdalksjflsjadfklsadf', 'Compact', 0);
INSERT INTO rentacar(id, address, city, description, name, rating)
VALUES (2, 'Bulevar oslobođenja 13/1',' Novi Sad', 'aksjfdalksjflsjadfklsadf', 'Europcar',0);
INSERT INTO rentacar(id, address, city, description, name, rating)
VALUES (3, 'Puškinova',' Novi Sad', 'aksjfdalksjflsjadfklsadf', 'NS 021',0);

INSERT INTO branch_locations(id, address, city, rentacar_id)
VALUES (1, 'Bulevar oslobođenja 13/1', 'Novi Sad', '1');
INSERT INTO branch_locations(id, address, city, rentacar_id)
VALUES (2, 'Svetosavska bb', 'Beocin', '1');
INSERT INTO branch_locations(id, address, city, rentacar_id)
VALUES (3, 'Puškinova 13', 'Novi Sad', '1');
INSERT INTO branch_locations(id, address, city, rentacar_id)
VALUES (4, 'Seljackih buna 13', 'Novi Sad', '2');
INSERT INTO branch_locations(id, address, city, rentacar_id)
VALUES (5, 'Bulevar Despota Stefana 66', 'Novi Sad', '3');

INSERT INTO vehicle (id,name, brand, model, year,seats,type, rating,price,reserved,rentacar_id,branch_locations_id,discount) 
VALUES (1,'vozilo1', 'RENAULT', 'Megane',  '2005', '5','2', '0' , '20', false,'1', '1',0.3);
INSERT INTO vehicle (id,name, brand, model, year,seats,type, rating,price,reserved,rentacar_id,branch_locations_id,discount) 
VALUES (4,'vozilo4', 'RENAULT', 'Clio',  '2005', '5','2', '0' , '20', false,'1', '2',0.1);
INSERT INTO vehicle (id,name, brand,model, year,seats,type, rating,price,reserved,rentacar_id,branch_locations_id,discount) 
VALUES (2, 'vozilo2', 'RENAULT', 'Clio',  '2005', '5', '1', '0', '30', false,'2', '4',0);
INSERT INTO vehicle (id,name, brand,model, year,seats,type, rating,price,reserved,rentacar_id,branch_locations_id,discount) 
VALUES (3, 'vozilo3', 'SKODA', 'Fabia',  '2008', '5','3', '0', '40', false,'3', '5',0);
INSERT INTO vehicle (id,name, brand, model, year,seats,type, rating,price,reserved,rentacar_id,branch_locations_id,discount) 
VALUES (5,'vozilo1', 'RENAULT', 'Laguna',  '2000', '5','2', '0' , '15', false,'1', '1',0.3);
INSERT INTO vehicle (id,name, brand, model, year,seats,type, rating,price,reserved,rentacar_id,branch_locations_id,discount) 
VALUES (6,'vozilo1', 'RENAULT', 'Capture',  '2010', '5','2', '0' , '50', false,'1', '1',0.3);

INSERT INTO vehicle_reservation(pickupdate,	dropoffdate,price,reservationdate,drop_off_location,pick_up_location,vehicle_id,abstract_user_id,rentacar_id,cancel) 
VALUES ('2019-1-1', '2019-2-14', 560, '2019-1-1', 'Bulevar oslobođenja 13/1', 'Bulevar oslobođenja 13/1', '1','1','1',false);
INSERT INTO vehicle_reservation(pickupdate,	dropoffdate,price,reservationdate,drop_off_location,pick_up_location,vehicle_id,abstract_user_id,rentacar_id,cancel) 
VALUES ('2019-2-14', '2019-2-25', 320, '2019-2-14', 'Bulevar oslobođenja 13/1', 'Bulevar oslobođenja 13/1', '4','1','1',false);
INSERT INTO vehicle_reservation(pickupdate,	dropoffdate,price,reservationdate,drop_off_location,pick_up_location,vehicle_id,abstract_user_id,rentacar_id,cancel) 
VALUES ('2019-2-26', '2019-3-14', 200, '2019-2-26', 'Bulevar oslobođenja 13/1', 'Bulevar oslobođenja 13/1', '1','5','1',false);

INSERT INTO rentacar_rating(rating, last_rating, sum_for_rating, rentacar)
VALUES (0,0,0,1);
INSERT INTO rentacar_rating(rating, last_rating, sum_for_rating, rentacar)
VALUES (0,0,0,2);
INSERT INTO rentacar_rating(rating, last_rating, sum_for_rating, rentacar)
VALUES (0,0,0,3);



