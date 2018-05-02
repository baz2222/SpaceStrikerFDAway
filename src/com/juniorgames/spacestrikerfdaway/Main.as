package com.juniorgames.spacestrikerfdaway
{
	import away3d.controllers.HoverController;
	import away3d.core.base.Geometry;
	import away3d.core.managers.Stage3DManager;
	import away3d.core.managers.Stage3DProxy;
	import away3d.entities.Mesh;
	import away3d.events.LoaderEvent;
	import away3d.events.Stage3DEvent;
	import away3d.lights.PointLight;
	import away3d.materials.TextureMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.textures.BitmapTexture;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.*;
	import flash.geom.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import away3d.containers.*;
	import away3d.debug.AwayStats;
	import away3d.loaders.*;
	import away3d.loaders.parsers.*;
	import away3d.library.*;
	import away3d.events.AssetEvent;
	import starling.core.Starling;
	public class Main extends Sprite 
	{
		private var v:View3D;
		private var s:Scene3D;
		private var sb:Rectangle;
		private var a:AwayStats;
		private var c:int;
		private var l:Loader3D;
		[Embed(source = "assets/mainblock/mainblock.awd", mimeType = "application/octet-stream")]
		private var JGModel:Class;
		private	var JGbmModelTexture:BitmapTexture;
		private var jgModel:Mesh;
		private var jgModelMaterial:TextureMaterial;
		private var jgModelContainer:ObjectContainer3D;
		private var jgLight1:PointLight;
		private var jgLight2:PointLight;
		private var jgLight3:PointLight;
		private var stage3DManager:Stage3DManager;
		private var stage3DProxy:Stage3DProxy;
		private var jgHC:HoverController;
		private var jgS:Starling;
		private var jgSParticles:Starling;
		private var jgWindowScale:Number;
		public function Main() 
		{
			//============================================================================
			jgReadSettings();
			jgInit();
			jgPreloaderEmbed();
			//============================================================================
		}
		
		private function jgInit():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.LOW;
			stage.displayState = StageDisplayState.NORMAL;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			jgInitProxies();
		}
		
		private function jgInitProxies():void 
		{
			stage3DManager = Stage3DManager.getInstance(stage);
			stage3DProxy = stage3DManager.getFreeStage3DProxy();
			stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, jgContextCreated);
			stage3DProxy.antiAlias = 2;
			stage3DProxy.color = 0x0;
			stage3DProxy.width = stage.stageWidth;
			stage3DProxy.viewPort.width = stage.stageWidth;
			stage3DProxy.height = stage.stageHeight;
			stage3DProxy.viewPort.height = stage.stageHeight;
		}
		
		private function jgContextCreated(e:Stage3DEvent):void 
		{
			jgInitA3D();
			jgInitStarling();
			jgInitListeners();
		}
		
		private function jgInitListeners():void 
		{
			stage3DProxy.addEventListener(Event.ENTER_FRAME, stage3DProxy_enterFrame);
			//stage3DProxy.clear();
			//stage3DProxy.present();
		}
		
		private function stage3DProxy_enterFrame(e:Event):void 
		{
			var jgStarlingSpriteInstance:JGStarlingSprite = JGStarlingSprite.getInstance();
			if (jgStarlingSpriteInstance)
			jgStarlingSpriteInstance.update();
			jgUpdateA3D();
			//stage3DProxy.clear();
			v.render();//BOTTOM LAYER
			jgS.nextFrame();//TOP LAYER
			//jgSParticles.nextFrame();
			//stage3DProxy.present();
		}
		
		private function jgUpdateA3D():void 
		{
			if (jgModel)
			{
			jgModel.rotationY++;
			}//end if
		}
		
		private function jgInitStarling():void 
		{
			jgS = new Starling(JGStarlingSprite, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
			//jgSParticles = new Starling(JGStarlingParticles, stage, stage3DProxy.viewPort, stage3DProxy.stage3D);
			jgS.stage.stageWidth = stage.stageWidth;
			//jgSParticles.stage.stageWidth = stage.stageWidth;
			jgS.stage.stageHeight = stage.stageHeight;
			//jgSParticles.stage.stageHeight = stage.stageHeight;
		}
		private function jgReadSettings():void
		{
		}
		private function jgPreloaderEmbed():void
		{
			AssetLibrary.enableParser(AWD2Parser);
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE,jgLoadingCompleteEmbed);
			AssetLibrary.loadData(new JGModel());
		}
		private function jgLoadingCompleteEmbed(e:AssetEvent):void
		{
			e.target.removeEventListener(AssetEvent.ASSET_COMPLETE,jgLoadingCompleteEmbed);
			jgModel = new Mesh(e.asset as Geometry);
			jgGameInit();
		}
		private function jgInitlights():void
		{
			jgLight1 = new PointLight();
			jgLight2 = new PointLight();
			jgLight3 = new PointLight();
			jgLight1.color = 0xffffff;
			jgLight2.color = 0x999999;
			jgLight3.color = 0x666666;
			jgLight1.position = new Vector3D(200,200,-200);
			jgLight2.position = new Vector3D(-200,200,-200);
			jgLight3.position = new Vector3D(0,200,200);
		}
		private function jgMaterialsInit():void
		{
			jgModel.material.lightPicker = new StaticLightPicker([jgLight1,jgLight2,jgLight3]);
		}
		private function jgGameInit():void
		{
			jgInitlights();
			jgMaterialsInit();
			jgAObjectsInit();
			jgCAMSetup();
		}
		private function jgAObjectsInit():void
		{
			s = v.scene;
			a = new AwayStats(v);
			s.addChild(jgLight1);
			s.addChild(jgLight2);
			s.addChild(jgLight3);
			s.addChild(jgModel);
			addChild(a);
		}
		private function jgCAMSetup():void
		{
			v.camera.z = -250;
			v.camera.y = 150;
			v.camera.lookAt(new Vector3D(0, 0, 0));
			v.camera.lens.far = 100000;
		}
		private function jgInitA3D():void
		{
			v = new View3D();
			v.stage3DProxy = stage3DProxy;
			v.shareContext = true;
			//jgHC = new HoverController(v.camera, null, 45, 30, 1200, 5, 89.999);
			this.addChild(v);
			v.antiAlias = 2;
			v.backgroundColor = 0x0;
			v.width = stage.stageWidth;
			v.height = stage.stageHeight;
			v.x = 0;
			v.y = 0;
		}
		private function deactivate(e:Event):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}