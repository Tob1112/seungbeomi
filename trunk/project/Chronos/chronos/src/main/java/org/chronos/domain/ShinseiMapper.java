package org.chronos.domain;

import java.util.HashMap;
import java.util.Map;

import org.chronos.domain.ChronosEnum.ShinseiJokyo;
import org.chronos.domain.ChronosEnum.ShinseiKubun;

public class ShinseiMapper {

	private static final String PARAMETER_NAME_SHINSEI_BANGO 	= "shinseiBango";
	private static final String PARAMETER_NAME_SHAIN_ID 		= "shainId";
	private static final String PARAMETER_NAME_SHINSEI_KUBUN 	= "shinseiKubun";
	private static final String PARAMETER_NAME_SHINSEI_JOKYO 	= "shinseiJokyo";
	private static final String PARAMETER_NAME_SHINSEI_FILE 	= "shinseiFile";
	private static final String PARAMETER_NAME_SHINSEI_KEKKA 	= "shinseiKekka";

	public static Shinsei mapping(ShinseiDto dto) {
		Shinsei mapped = new Shinsei();

		mapped.setShinseiBango(dto.getShinseiBango());
		mapped.setShainId(dto.getShainId());
		mapped.setShinseiKubun(ShinseiKubun.fromCode(dto.getShinseiKubun()));
		mapped.setShinseiJokyo(ShinseiJokyo.fromCode(dto.getShinseiJokyo()));
		mapped.setShinseiFile(dto.getShinseiFile());
		mapped.setShinseiKekka(dto.getShinseiKekka());

		return mapped;
	}

	public static Map<String, Object> mapping(Shinsei shinsei) {
		Map<String, Object> mapped = new HashMap<String, Object>();
		mapped.put(PARAMETER_NAME_SHINSEI_BANGO, shinsei.getShinseiBango());
		mapped.put(PARAMETER_NAME_SHAIN_ID, shinsei.getShainId());
		mapped.put(PARAMETER_NAME_SHINSEI_KUBUN, shinsei.getShinseiKubun());
		mapped.put(PARAMETER_NAME_SHINSEI_JOKYO, shinsei.getShinseiJokyo());
		mapped.put(PARAMETER_NAME_SHINSEI_FILE, shinsei.getShinseiFile());
		if (shinsei.getShinseiKekka() != null) {
			mapped.put(PARAMETER_NAME_SHINSEI_KEKKA, shinsei.getShinseiKekka());
		} else {
			mapped.put(PARAMETER_NAME_SHINSEI_KEKKA, "");
		}

		return mapped;
	}

}
