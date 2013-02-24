package sitelock 
{
/**
	 * SiteLock by skyboy. August 8th 2010.
	 * Visit http://github.com/skyboy for documentation, updates
	 * and more free code.
	 *
	 *
	 * Copyright (c) 2010, skyboy
	 *    All rights reserved.
	 *
	 * Permission is hereby granted, free of charge, to any person
	 * obtaining a copy of this software and associated documentation
	 * files (the "Software"), to deal in the Software without
	 * restriction, including without limitation the rights to use,
	 * copy, modify, merge, publish, distribute, sublicense, and/or sell
	 * copies of the Software, and to permit persons to whom the
	 * Software is furnished to do so, subject to the following
	 * conditions:
	 *
	 * ^ Attribution will be given to:
	 *  	skyboy, http://www.kongregate.com/accounts/skyboy;
	 *  	http://github.com/skyboy; http://skybov.deviantart.com
	 *
	 * ^ Redistributions of source code must retain the above copyright notice,
	 * this list of conditions and the following disclaimer in all copies or
	 * substantial portions of the Software.
	 *
	 * ^ Redistributions of modified source code must be marked as such, with
	 * the modifications marked and ducumented and the modifer's name clearly
	 * listed as having modified the source code.
	 *
	 * ^ Redistributions of source code may not add to, subtract from, or in
	 * any other way modify the above copyright notice, this list of conditions,
	 * or the following disclaimer for any reason.
	 *
	 * ^ Redistributions in binary form must reproduce the above copyright
	 * notice, this list of conditions and the following disclaimer in the
	 * documentation and/or other materials provided with the distribution.
	 *
	 * THE SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
	 * IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
	 * NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
	 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
	 * OR COPYRIGHT HOLDERS OR CONTRIBUTORS  BE LIABLE FOR ANY CLAIM, DIRECT,
	 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
	 * OR OTHER LIABILITY,(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
	 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
	 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
	 * WHETHER AN ACTION OF IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
	 * NEGLIGENCE OR OTHERWISE) ARISING FROM, OUT OF, IN CONNECTION OR
	 * IN ANY OTHER WAY OUT OF THE USE OF OR OTHER DEALINGS WITH THIS
	 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
	 */
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	public class SiteLock extends Sprite {
		public function SiteLock(navigateOnFail:Boolean = true, hideOnFail:Boolean = false) {
			hide = hideOnFail;
			navigate = navigateOnFail;
			sites = new Array();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private var sites:Array, siteToNav:URLRequest;
		private var hide:Boolean = false, navigate:Boolean = false, local:Boolean = false;
		private function init(e:Event = null):void {
			var info:LoaderInfo = stage.loaderInfo;
			var url:String = info.loaderURL;
			if (/^file:\/\//.test(url)) {
				if (local) {
					return;
				}
				throw new Error("You are not allowed to play this SWF locally.");
			}
			var match:RegExp = /^(?:https?:\/\/)?([^\/]+)/i
			var site:String = url.match(match)[1];
			var s:RegExp, g:Boolean = false;
			for each(s in sites) {
				if (s.test(site) || s.test(url)) {
					g = true;
					break;
				}
			}
			url = info.url;
			site = url.match(match)[1];
			for each(s in sites) {
				if (s.test(site) || s.test(url)) {
					g = g && true;
					break;
				}
			}
			if (!g) {
				if (hide) {
					root.visible = false;
					root.alpha = 0;
				}
				if (navigate) {
					if (!siteToNav) {
						siteToNav = new URLRequest("http://www.kongregate.com/");
					}
					setTimeout(navigateToURL, 0, siteToNav, "_top");
				}
				throw new Error("This SWF is hosted illegally.")
			}
		}
		public function addSite(url:String, exact:Boolean = true):void {
			var a:String = url;
			if (!siteToNav) {
				if (!(/^((ht|f)tps?):\/\//.test(a))) {
					a = "http://" + a;
				}
				siteToNav = new URLRequest(a);
			}
			url = url.replace(/^(?:(?:ht|f)tps?:\/\/)??([^\/]+)/i, '$1').toLowerCase();
			url = url.replace(/([.?\}\{\[\]\(\)\\\-*+$^|])/g, "\\$1");
			sites.push(new RegExp((exact ? "^" : "^(.+\\.)*") + url + "$", "i"));
		}
		public function allowRegExp(regexp:RegExp):void {
			sites.push(regexp);
		}
		public function setNavigateURL(url:String):void {
			if (url) {
				siteToNav = new URLRequest(url);
			}
		}
		public function allowLocalPlay(enabled:Boolean = false):void {
			local = enabled;
		}
		public function testIsAllowed(url:String):Boolean {
			var match:RegExp = /^(?:https?:\/\/)?([^\/]+)/i
			var site:String = url.match(match)[1];
			var s:RegExp, g:Boolean = false;
			for each(s in sites) {
				if (s.test(site)) {
					return true;
				}
			}
			return false;
		}
	}

}