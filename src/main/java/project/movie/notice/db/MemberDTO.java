package project.movie.notice.db;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberDTO {

	private int Mem_num;
	private String Mem_name;
	private String Mem_id;
	private String Mem_pw;
	private String Mem_phone;
	private Date Mem_birth;
	private String Mem_grade;
	private String Mem_addr;
	private String Mem_email;
	private String Mem_mType;
	private Timestamp Mem_joinDate;
	private int rCount;
}
