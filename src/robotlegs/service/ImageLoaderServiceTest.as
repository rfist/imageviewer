package robotlegs.service
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.async.Async;
	
	import robotlegs.model.GalleryModel;

	public class ImageLoaderServiceTest
	{		
		private var loader: ImageLoaderService;
		private var galleryModel: GalleryModel;
		private var dispatcher: EventDispatcher;
		private var loadedItems: Array;
		private var sizeArray: Array;
		
		[Before (async)]
		public function setUp():void
		{
			loader = new ImageLoaderService();
			galleryModel = new GalleryModel();
			dispatcher = new EventDispatcher();
			loadedItems = [];
			sizeArray = [];
				
			for (var i:int = 0; i < galleryModel.linksList.length; i++)
			{
				loader.add(galleryModel.linksList[i], onLoad);
			}
			galleryModel.lastLoadedIndex = i;	
			Async.proceedOnEvent(this, dispatcher, Event.COMPLETE, 20000);
			loader.load(onLoadComplete);
			
		}
		
		private function onLoad(result: LoaderEvent): void
		{
			var img:DisplayObject = result.target.content;
			img.height = Config.IMAGE_HEIGHT;
			img.scaleX = img.scaleY;
			trace('load', result.target.request.url);
			sizeArray.push(img.width);
			loadedItems.push(result.target.request.url);
		}
		
		private function onLoadComplete(): void
		{
			dispatcher.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
		[Test(async,  description = "images load test" )]
		public function loadTest():void
		{
			trace("sizes", sizeArray);
			assertEquals(loadedItems.length, galleryModel.linksList.length);
		}
		
		
	}
}