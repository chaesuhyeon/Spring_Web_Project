package org.zerock.mapper;

import org.apache.ibatis.annotations.*;

;

public interface TimeMapper {

	@Select("select sysdate from dual")
	String getTime();
}
