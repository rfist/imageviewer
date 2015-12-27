package robotlegs.controller
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.assertThat;
	import org.flexunit.asserts.assertEquals;
	import org.flexunit.async.Async;
	
	public class SortByWidthCommandTest
	{	
		private const IMAGE_HOLDER_WIDTH: Number = 900;
		private var dispatcher: EventDispatcher;
		private var command: SortByWidthCommand; 
		private var _bins:Array = [];
		private var _binSizes:Array = [];
		private var input: Array = [97.05,150,133.95,200,225.45,232.95,151.8,200,100.25,200,224.55,300,150,150,240.6,231.3,128.7,200.8,266.65,225.65,200,233.1,150,200.25,225];
		
		[Before (async)]
		public function setUp():void
		{
			dispatcher = new EventDispatcher();
			command = new SortByWidthCommand();
			Async.proceedOnEvent(this, dispatcher, Event.COMPLETE, 20000);
			command.testExecute(input, onComplete);
		}
		
		private function onComplete(bins: Array, binSizes: Array):void
		{
			_bins = bins;
			_binSizes = binSizes;
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
		
		[Test]
		public function testAllItemsAreSorted():void
		{
			var totalCount: int = 0;
			for (var i:int = 0; i < _bins.length; i++)
			{
				totalCount += _bins[i].length;
			}
			assertEquals(input.length, totalCount);

		}
		
		[Test]
		public function testIfContainerEnoughForImages():void
		{
			var isEnough: Boolean = true;
				
			for (var i:int = 0; i < _bins.length; i++)
			{
				var totalWidth: int = 0;
				for (var j:int = 0; j < _bins[i].length; j++)
				{
					totalWidth += _bins[i][j];
				}
				trace('total width', totalWidth);
				if (totalWidth > IMAGE_HOLDER_WIDTH)
				{
					isEnough = false;
				}
			}
			assertEquals(isEnough, true);
			
			
		}
	}
}