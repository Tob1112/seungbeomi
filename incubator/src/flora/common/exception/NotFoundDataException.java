package flora.common.exception;

@SuppressWarnings("serial")
public class NotFoundDataException extends FloraException{

	public NotFoundDataException(){
		super("I can't find data");
	}
	
	public NotFoundDataException(Exception e) {
		super(e);
	}
	
	public NotFoundDataException(String message){
		super(message);
	}
}
