import { Component, OnInit } from '@angular/core';
import { HotelExtra } from 'src/app/hotel-extras';
import { HotelExtrasService } from 'src/services/hotel-extras.service';
import { HotelService } from 'src/services/hotel.service';
import { Router, ActivatedRoute } from '@angular/router';
import { NgForm } from '@angular/forms';
import { extractDirectiveDef } from '@angular/core/src/render3/definition';

@Component({
  selector: 'app-extras-add',
  templateUrl: './extras-add.component.html',
  styleUrls: ['./extras-add.component.scss']
})
export class ExtrasAddComponent implements OnInit {

  hotel : any;
  extra : HotelExtra = new HotelExtra();

  constructor(private extrasService : HotelExtrasService, private hotelService : HotelService, private router : Router, private ar : ActivatedRoute) { }


  ngOnInit() {
    const hotelId : number = this.ar.snapshot.params['id'];
    this.hotelService.get(hotelId).subscribe(data =>{
      this.hotel = data;
    });
    this.extra.unit = "PER_DAY";
  }

  gotoList() {
    this.router.navigate(['hotel/edit/'+ this.hotel.id + '/extras']);
  }

  save(form : NgForm) {
    this.extra.hotel = this.hotel;
    this.extrasService.save(this.extra).subscribe(result => {
      this.gotoList();
    }, error => console.error(error));
  }

}
