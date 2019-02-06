package com.isa.airflights.controller;

import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.isa.airflights.model.Hotel;
import com.isa.airflights.model.Room;
import com.isa.airflights.model.RoomReservation;
import com.isa.airflights.model.SearchObject;
import com.isa.airflights.service.AdminService;
import com.isa.airflights.service.HotelService;
import com.isa.airflights.service.RoomReservationService;
import com.isa.airflights.service.RoomService;

@RestController
@RequestMapping(value="/api/hotel")
@CrossOrigin(origins = "http://localhost:4200")
public class HotelController {
	
	@Autowired
	private HotelService service;
	
	//@Autowired
	//private AdminService as;

	@Autowired
	private RoomService rService;
	
	@Autowired
	private RoomReservationService rrService;
	
    @GetMapping("/list")
    public Collection<Hotel> hotels() {
    	//System.out.println("Pokupio");
        return service.getAll();
    }
    
    @GetMapping("/{id}" )
    public ResponseEntity<Hotel> getHotel(@PathVariable("id") Long id) {
    	
    	Hotel hotel;
    	try {
    		 hotel = service.getOne(id);
    	} catch (EntityNotFoundException e) {
    		return new ResponseEntity<Hotel>(HttpStatus.NOT_FOUND);
		}
    	
        return new ResponseEntity<Hotel>(hotel, HttpStatus.OK);
    }
    
    @RequestMapping(value="/add", method = RequestMethod.POST, 
			consumes = MediaType.APPLICATION_JSON_VALUE, 
			produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Hotel> addHotel(@RequestBody Hotel hotel) {
		
    	service.save(hotel);
    	
    	return new ResponseEntity<Hotel>(hotel,HttpStatus.CREATED);
    }
    
    @RequestMapping(value="/", method = RequestMethod.PUT, 
			consumes = MediaType.APPLICATION_JSON_VALUE, 
			produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Hotel> updateHotel(@RequestBody Hotel hotel) {
		
    	service.update(hotel);
    	
    	return new ResponseEntity<Hotel>(hotel,HttpStatus.CREATED);
    }
    
    @RequestMapping(value="/{id}", method = RequestMethod.DELETE,
			produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Hotel> deleteHotel(@PathVariable("id") Long id) {
    	service.delete(id);
    	
    	return new ResponseEntity<Hotel>(HttpStatus.OK);
    }
    
    /**
     * Ne koristi se za sada
     * @param id
     * @return
     */
    @RequestMapping(value="/{id}/rooms", method = RequestMethod.GET,
			produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Hotel> getRooms(@PathVariable("id") Long id) {
		
    	Hotel h = service.getOne(id);
    	System.out.println(h.getName());
    	System.out.println(h.getAddress());
    	//service.getRooms(id);
    	
    	return new ResponseEntity<Hotel>(HttpStatus.OK);
    }
    
    @RequestMapping(value="/search", method = RequestMethod.POST,
    		consumes = MediaType.APPLICATION_JSON_VALUE,
    		produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Set<Hotel>> search(@RequestBody SearchObject obj) {
		
    	List<Hotel> hotels = service.getFiltered(obj);
    	//List<Room> rooms = rService.getAll();
    	
    	Date from = new GregorianCalendar(obj.getStartY(), obj.getStartM()-1, obj.getStartD()).getTime();
    	Date to = new GregorianCalendar(obj.getEndY(), obj.getEndM()-1, obj.getEndD()).getTime();
    	  
    	Set<Hotel> set = new HashSet<>();
    	
    	for (Hotel hotel : hotels) {
    		List<Room> rooms = rService.getRoomByHotel(hotel.getId());
    		ROOM_LOOP:
    		for (Room room : rooms) {
    			List<RoomReservation> reservations = rrService.getByRoom(room.getId());
    			for (RoomReservation reservation : reservations) {
    				Date exf = reservation.getStartDate();
    				Date ext = reservation.getEndDate();
    				
					if (!(exf.after(to) || ext.before(from)))  {
						break ROOM_LOOP;	
					}
    			}
    			set.add(hotel);
    		}
    	}
		return new ResponseEntity<Set<Hotel>>(set, HttpStatus.OK);
	}
}
