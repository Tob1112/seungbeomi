package net.sourceforge.pebble.util;

/**
 * This class is used to keep track of a thread local instance 
 * for rewriting URLs - ultimately for deciding if a link should
 * be decorated 'secure' (as in config value secureUrl) or plain.
 * 
 * The initialization (and clean up) is meant to be done in a 
 * servlet filter, so that the thread local rewriter is available 
 * to each request. This is done because a blog itself serves its
 * Url to anybody and doesn't know how to determine if it should be
 * talked to 'secure' or not.
 * 
 * In the current scenario, secureUrl may be used for logging in 
 * and performing administrative work. Be aware though that mixing
 * http and https access to an application may itself impose severe
 * risk while the user feels comfortably safe. Best and most secure 
 * mode for operation would be to go https exclusively. If you 
 * can't, the current solution (this class is participating in)
 * will help you the best it can.
 * 
 * @author Olaf Kock
 *
 */

public abstract class UrlRewriter {
	private static TheRewriter x = new TheRewriter(); 
	
	/**
	 * Initialize the threadlocal urlRewriter. The given rewriter 
	 * will be used until this method is called again (or clear()
	 * is called) 
	 * @param urlRewriter
	 */
	public static void useThisRewriter(UrlRewriter urlRewriter) {
		x.set(urlRewriter);
	}
	
	/**
	 * Urls will not be rewritten after this call - this clears 
	 * the threadlocal UrlRewriter.
	 */
	public static void clear() {
		x.remove();
	}

	/**
	 * Delegate url rewriting to the current threadlocal rewriter.
	 * @param url
	 * @return
	 */
	public static String doRewrite(String url) {
		return x.get().rewrite(url);
	}

	/**
	 * This class serves as its own interface for the implementing 
	 * UrlRewriters. Might be seen as a bit unclean, but keeps the 
	 * implementation tightly together without introducing another
	 * one-method-interface.
	 * @param url
	 * @return
	 */
	abstract public String rewrite(String url);
	
	private static class TheRewriter extends ThreadLocal<UrlRewriter> {
		@Override
		protected UrlRewriter initialValue() {
			return NullUrlRewriter.instance;
		}
	}
}
