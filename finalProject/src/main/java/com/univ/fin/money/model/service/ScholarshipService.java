package com.univ.fin.money.model.service;

import java.util.ArrayList;

import com.univ.fin.money.model.vo.Scholarship;

public interface ScholarshipService {

	ArrayList<Scholarship> selectMyScholarshipList(Scholarship sc);

}
