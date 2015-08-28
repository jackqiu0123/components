/**
 * ===================================
 * Author:	iDzeir					
 * Email:	qiyanlong@wozine.com	
 * Company:	http://www.acfun.tv		
 * Created:	Aug 12, 2015 3:34:38 PM			
 * ===================================
 */

package com.idzeir.utils
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 * 皮肤资源管理
	 */	
	public class AssetsManager
	{
		private static var _instance:AssetsManager;
		//资源表
		private var _map:Dictionary = new Dictionary(true);
		//正在执行的加载队列
		private var _queue:Dictionary = new Dictionary(true);
		
		public function AssetsManager()
		{
			if(_instance)
				throw new Error("单例模式"+_instance);
		}
		
		public static function getInstance():AssetsManager
		{
			return _instance ||= new AssetsManager();
		}
		/**
		 * 获取外部图片资源 共享一个bitmapdata，返回新的bitmap
		 * @param url 图片地址
		 * @param ok 成功回调，参数数bitmap
		 * @param fail 错误回调，参数数错误原因
		 */		
		public function getImage(url:String, ok:Function, fail:Function = null):void
		{
			var key:String = escape(url);
			var assets:ImageAssets;
			
			if(has(key))
			{
				//trace("存在缓存数据");
				assets = (_map[key] as ImageAssets);
				ok.apply(null,[assets.getData()])
			}else{
				//没有缓存记录
				if(!_queue.hasOwnProperty(key))
				{
					//没有存在在加载队列中
					_queue[key] = [Watcher.createImage(key,ok,fail)];
				}else{
					//trace("重复加载地址");
					_queue[key].push(Watcher.createImage(key,ok,fail));
					return;
				}
				
				var keyMap:Array = _queue[key];
				var loader:Loader = new Loader();
				var failHandler:Function = function(e:Event):void
				{
					clear();
					keyMap.forEach(function(w:Watcher,index:int,arr:Array):void
					{
						if(w.fail)
						{
							try
							{
								w.fail.apply(null,[e.type]);
							}catch(error:Error){
								trace("资源加载失败回调函数出错：",unescape(w.url),error.message);
							}
						}
					});
					_queue[key] = null;
				};
				var okHandler:Function = function(e:Event):void
				{
					clear();
					assets = _map[key] = new ImageAssets(loader.contentLoaderInfo);
					keyMap.forEach(function(w:Watcher,index:int,arr:Array):void
					{
						try
						{
							w.ok.apply(null,[assets.getData()]);
						}catch(error:Error){
							trace("资源加载成功回调函数出错：",unescape(w.url),error.message);
						}
					});
					_queue[key] = null;
				};
				var clear:Function = function():void
				{
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,failHandler);
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,okHandler);
				}
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,failHandler);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,okHandler);
				loader.load(new URLRequest(key));
			}
		}
		
		/**
		 * 获取外部swf资源或swf本身
		 * @param url swf资源地址
		 * @param definition 是否从swf中取得指定名称的资源
		 * @param ok 成功回调 参数是swf或者内部资源的现实实例
		 * @param fail 参数是失败原因
		 */		
		public function getEmbed(url:String,definition:String = null,ok:Function = null,fail:Function = null):void
		{
			var key:String = escape(url);
			var assets:SWFAssets;
			
			if(has(key))
			{
				trace("存在缓存数据");
				assets = (_map[key] as SWFAssets);
				assets.definition = definition;
				ok.apply(null,[assets.getData()])
			}else{
				//没有缓存记录
				if(!_queue.hasOwnProperty(key))
				{
					//没有存在在加载队列中
					_queue[key] = [Watcher.createEmbed(key,definition,ok,fail)];
				}else{
					trace("重复加载地址");
					_queue[key].push(Watcher.createEmbed(key,definition,ok,fail));
					return;
				}
				
				var keyMap:Array = _queue[key];
				var loader:Loader = new Loader();
				var failHandler:Function = function(e:Event):void
				{
					clear();
					keyMap.forEach(function(w:Watcher,index:int,arr:Array):void
					{
						if(w.fail)
						{
							try
							{
								w.fail.apply(null,[e.type]);
							}catch(error:Error){
								trace("资源加载失败回调函数出错：",unescape(w.url),error.message);
							}
						}
					});
					_queue[key] = null;
				};
				var okHandler:Function = function(e:Event):void
				{
					clear();
					assets = _map[key] = new SWFAssets(loader.contentLoaderInfo);
					keyMap.forEach(function(w:Watcher,index:int,arr:Array):void
					{
						assets.definition = definition;
						try
						{
							w.ok.apply(null,[assets.getData()]);
						}catch(error:Error){
							trace("资源加载成功回调函数出错：",unescape(w.url),error.message);
						}
					});
					_queue[key] = null;
				};
				var clear:Function = function():void
				{
					loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,failHandler);
					loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,okHandler);
				}
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,failHandler);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,okHandler);
				loader.load(new URLRequest(key));
			}
		}
		
		/**
		 * 判断是否加载过地址
		 */		
		internal function has(url:String):Boolean
		{
			var key:String = url;
			if(_map.hasOwnProperty(key)&&_map[key]!=null)
			{
				return true;
			}
			return false;
		}
	}
}

class Watcher
{
	private static const SWF:String = "swf";
	private static const IMAGE:String = "image";
	
	private var _type:String = IMAGE;
	
	public var url:String;
	public var definition:String;
	public var ok:Function;
	public var fail:Function
	
	public function get type():String
	{
		return _type;
	}
	
	public static function createEmbed(url:String,definition:String = null,ok:Function = null,fail:Function = null):Watcher
	{
		var w:Watcher = new Watcher();
		w._type = SWF;
		w.url = url;
		w.definition = definition;
		w.ok = ok;
		w.fail = fail;
		return w;
	}
	
	public static function createImage(url:String, ok:Function, fail:Function = null):Watcher
	{
		var w:Watcher = new Watcher();
		w._type = IMAGE;
		w.url = url;
		w.ok = ok;
		w.fail = fail;
		return w;
	}
}

//==============

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.LoaderInfo;
import flash.display.Sprite;

interface IAssets
{
	function getData():DisplayObject;
	function set key(value:String):void;
	function get key():String;
}

//===============

class ImageAssets implements IAssets
{
	private var _key:String;
	private var _info:LoaderInfo;
	
	private var bmd:BitmapData;
	
	public function ImageAssets(info:LoaderInfo)
	{
		_info = info;
		bmd = new BitmapData(info.width,info.height,true,0x00FFFFFF);
		bmd.draw(info.content,null,null,null,null,true);
	}
	public function getData():DisplayObject
	{
		return new Bitmap(bmd,"auto",true);
	}
	public function set key(value:String):void
	{
		_key = value;
	}
	public function get key():String
	{
		return _key;
	}
}

//================

class SWFAssets implements IAssets
{
	private var _key:String;
	private var _definition:String;
	private var _info:LoaderInfo;
	
	public function SWFAssets(info:LoaderInfo):void
	{
		_info = info;
	}
	
	public function set definition(value:String):void
	{
		_definition = value;
	}
	
	public function getData():DisplayObject
	{
		if(_definition==null||_definition.length == 0)
		{
			return _info.content;
		}
		
		if(_info.applicationDomain.hasDefinition(_definition))
		{
			var cls:Class = _info.applicationDomain.getDefinition(_definition) as Class;
			if(cls)
			{
				return new cls() as DisplayObject;
			}
		}
		trace("SWF 资源文件中找不到指定内容：",_definition);
		return new Sprite();
	}
	public function set key(value:String):void
	{
		_key = value;
	}
	public function get key():String
	{
		return _key;
	}
}
