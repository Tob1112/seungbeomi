/*
 * Copyright (c) 2003-2006, Simon Brown
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *
 *   - Neither the name of Pebble nor the names of its contributors may
 *     be used to endorse or promote products derived from this software
 *     without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */
package net.sourceforge.pebble.web.listener;

import java.util.Collection;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.sourceforge.pebble.Configuration;
import net.sourceforge.pebble.PebbleContext;
import net.sourceforge.pebble.dao.DAOFactory;
import net.sourceforge.pebble.domain.Blog;
import net.sourceforge.pebble.domain.BlogEntry;
import net.sourceforge.pebble.domain.BlogManager;
import net.sourceforge.pebble.domain.BlogService;
import net.sourceforge.pebble.domain.BlogServiceException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * Allows the blog to be loaded when this web application is started up.
 *
 * @author    Simon Brown
 */
public class PebbleContextListener implements ServletContextListener {

  /** the log used by this class */
  private static Log log = LogFactory.getLog(PebbleContextListener.class);

  /**
   * Called when the web application is started.
   *
   * @param event   a ServletContextEvent instance
   */
  public void contextInitialized(ServletContextEvent event) {
    long startTime = System.currentTimeMillis();
    log.info("Starting Pebble");

    ApplicationContext applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(event.getServletContext());
    Configuration config = (Configuration)applicationContext.getBean("pebbleConfiguration");

    DAOFactory.setConfiguredFactory(config.getDaoFactory());
    PebbleContext ctx = PebbleContext.getInstance();
    ctx.setConfiguration(config);
    ctx.setWebApplicationRoot(event.getServletContext().getRealPath("/"));

    BlogManager.getInstance().setMultiBlog(config.isMultiBlog());
    BlogManager.getInstance().startBlogs();

    // find those blogs with no entries and add a welcome note
    Collection<Blog> blogs = (Collection<Blog>)BlogManager.getInstance().getBlogs();
    for (Blog blog : blogs) {
      try {
        // and add a default entry, if one doesn't exist
        if (blog.getNumberOfBlogEntries() == 0) {
          log.info("Creating 'welcome note' blog entry for " + blog.getId());
          BlogEntry blogEntry = new BlogEntry(blog);
          blogEntry.setTitle("Welcome");
          blogEntry.setBody(
              "<p>\n" +
              "Welcome to your new Pebble powered blog. Here are a few suggestions for getting started.\n" +
              "</p>\n" +
              "\n" +
              "<ul>\n" +
              "<li>Login to see the admin features of your blog. The default username is <code>username</code> and the password is <code>password</code>.</li>\n" +
              "<li>Modify your <a href=\"viewBlogProperties.secureaction\">blog properties</a></li>\n" +
              "<li><a href=\"addBlogEntry.secureaction\">Create a new blog entry</a>.</li>\n" +
              "<li>Give out a link to your <a href=\"./rss.xml\">RSS</a> feed.</li>\n" +
              "<li>Remove the default user and create your own user on the <a href=\"viewUsers.secureaction\">users page</a>.</li>\n" +
              "<li>Take a look at the <a href=\"./help/index.html\">online help</a>.</li>\n" +
              "<li>Delete this blog entry when you're finished with it.</li>\n" +
              "</ul>\n" +
              "\n" +
              "<p>\n" +
              "Have fun!\n" +
              "</p>");
          blogEntry.setAuthor("username");
          blogEntry.setPublished(true);
          BlogService service = new BlogService();
          service.putBlogEntry(blogEntry);
        }
      } catch (BlogServiceException e) {
        log.warn("Could not store 'welcome note' blog entry for " + blog.getId());
      }
    }

    long endTime = System.currentTimeMillis();
    log.info("Pebble started in " + (endTime-startTime) + "ms");
  }

  /**
   * Called when the web application is shutdown.
   *
   * @param event   a ServletContextEvent instance
   */
  public void contextDestroyed(ServletContextEvent event) {
    log.info("Stopping Pebble");
    BlogManager.getInstance().stopBlogs();

    log.info("Pebble stopped");
  }

}
