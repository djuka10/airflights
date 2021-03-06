package com.isa.airflights.service;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.isa.airflights.model.Hotel;
import com.isa.airflights.model.SearchObject;
import com.isa.airflights.repository.HotelRepository;

@Service
public class HotelService {

	@Autowired
	private HotelRepository repository;
	
	//@Autowired
	//private AbstractUserRepository rs;

	public Collection<Hotel> getAll() {
		return repository.findAll().stream().collect(Collectors.toList());
	}

	public Hotel getOne(Long id) {
		return repository.getOne(id);
	}

	public Hotel save(Hotel hotel) {
		return repository.save(hotel);
	}

	@Transactional(readOnly = false, propagation=Propagation.REQUIRES_NEW)
	public Hotel update(Hotel hotel) {
		return repository.save(hotel);
	}
	
	public void  delete(Long id) {
		repository.deleteById(id);
	}

	public List<Hotel> getFiltered(SearchObject obj) {
		List<Hotel> all = repository.findAll();
		
		List<Hotel> f1 = all.stream().filter(h -> h.getName().toLowerCase().trim().contains(obj.getName().toLowerCase().trim())).collect(Collectors.toList());
		List<Hotel> f2 = f1.stream().filter(h -> h.getCity().toLowerCase().trim().contains(obj.getLocation().toLowerCase().trim())).collect(Collectors.toList());
		
		return f2;
	}
	
	
	
}
