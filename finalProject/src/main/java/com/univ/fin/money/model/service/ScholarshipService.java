package com.univ.fin.money.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.univ.fin.money.model.vo.Scholarship;

public interface ScholarshipService {

	ArrayList<Scholarship> selectMyScholarshipList(Scholarship sc);

	int insertScholarship(Scholarship sc);

	int deleteScholarship(Scholarship sc);

	Scholarship selectOneScholarship(int schNo);

	int updateScholarship(Scholarship sc);

	ArrayList<Scholarship> selectScholarshipListAll(HashMap<String, String> map);

}
