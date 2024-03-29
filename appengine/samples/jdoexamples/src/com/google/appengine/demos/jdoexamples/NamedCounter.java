/* Copyright (c) 2009 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.appengine.demos.jdoexamples;

import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.datastore.KeyFactory;

@PersistenceCapable(identityType = IdentityType.APPLICATION, detachable = "true")
public class NamedCounter {

	@PrimaryKey
	private String name;

	@Persistent
	private int count;

	public NamedCounter(String name) {
		// You have to supply the keyName here, event though this
		// field later becomes the serialized Key.
		this.name = name;
		this.count = 0;
	}

	public int getCount() {
		return count;
	}

	public void add(int delta) {
		count += delta;
	}

	public String getName() {
		// Once submitted, the @PrimaryKey will be turned into
		// a serialized Key instance, which is why we need to
		// do this stuff.
		return KeyFactory.stringToKey(name).getName();
	}
}
