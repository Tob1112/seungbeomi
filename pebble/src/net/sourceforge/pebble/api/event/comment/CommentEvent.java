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
package net.sourceforge.pebble.api.event.comment;

import net.sourceforge.pebble.api.event.PebbleEvent;
import net.sourceforge.pebble.domain.Comment;

/**
 * Event to signify that a comment has been added/removed.
 *
 * @author Simon Brown
 */
public class CommentEvent extends PebbleEvent {

  /** constant representing comment added type */
  public static final int COMMENT_ADDED = 0;

  /** constant representing comment removed type */
  public static final int COMMENT_REMOVED = 1;

  /** constant representing comment approved type */
  public static final int COMMENT_APPROVED = 2;

  /** constant representing comment rejected type */
  public static final int COMMENT_REJECTED = 3;

  /**
   * Creates a new instance with the specified source and type.
   *
   * @param comment   the comment that initiated this event
   * @param type        the type of this event
   */
  public CommentEvent(Comment comment, int type) {
    super(comment, type);
  }

  /**
   * Gets the Comment that is the source of this event.
   *
   * @return  a Comment instance
   */
  public Comment getComment() {
    return (Comment)getSource();
  }

}
