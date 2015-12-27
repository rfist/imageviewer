package robotlegs.controller
{
	import flash.display.DisplayObject;

	import org.robotlegs.mvcs.Command;

	import robotlegs.model.GalleryModel;
	import robotlegs.model.SystemEvent;
	import robotlegs.view.GalleryItem;

	/**
	 * SortByWidthCommand.
	 *
	 */
	public class SortByWidthCommand extends Command
	{
		[Inject]
		public var galleryModel:GalleryModel;

		private var _bins:Array = [];
		private var _binSizes:Array = [];
		private var _average:int = 0;
		private var _maxDeviation:int = 0;

		public function SortByWidthCommand()
		{

		}


		// http://stackoverflow.com/questions/5626520/fitting-n-variable-height-images-into-3-similar-length-column-layout/5689594#5689594
		override public function execute():void
		{
			var widths:Array = getWidthArray();
			first_fit(widths);
			while (true)
			{
				if (!swap())
				{
					break;
				}
			}
			sortImages();
		}

		public function testExecute(arr: Array, onComplete: Function): void
		{
			first_fit(arr);
			while (true)
			{
				if (!swap())
				{
					break;
				}
			}
			onComplete(_bins, _binSizes);
		}

		private function sortImages(): void
		{
			var images:Vector.<GalleryItem> = galleryModel.loadedItems.concat();
			var sortedImages:Array = [];
			for (var a:int = 0; a < _bins.length; a++)
			{
				sortedImages.push([]);
				for (var b:int = 0; b < _bins[a].length; b++)
				{
					for (var i:int = 0; i < images.length; i++)
					{
						if (int(_bins[a][b]) == int(images[i].source.width))
						{
							sortedImages[a].push(images[i]);
							images.splice(i, 1);
							break;
						}
					}
				}
			}
			galleryModel.sortedImages = sortedImages;
			eventDispatcher.dispatchEvent(new SystemEvent(SystemEvent.SHOW_IMAGES_REQUESTED));
		}

		private function getWidthArray(): Array
		{
			//todo:: calculate count of used images before filling!
			var result:Array = [];
			for (var i:int = 0; i < galleryModel.loadedItems.length; i++)
			{
				result.push(galleryModel.loadedItems[i].source.width);
			}
			return result;
		}

		private function swap(): Boolean
		{
			var i_a:int;
			for (var z:int = 0; z < _binSizes.length; z++)
			{
				if (_average - _binSizes[z] == _maxDeviation)
				{
					i_a = z;
				}
			}

			var col_a:Array = _bins[i_a];

			for each (var pic_a:Number in removeDuplicates(col_a))
			{
				for (var i_b:int = 0; i_b < _bins.length; i_b++)
				{
					if (i_a != i_b)
					{
						var col_b:Array = _bins[i_b];
						for each (var pic_b:Number in removeDuplicates(col_b))
						{
							if (Math.abs(pic_a - pic_b) > _maxDeviation)
							{
								var new_a:Number = _binSizes[i_a] - pic_a + pic_b;
								var new_b:Number = _binSizes[i_b] - pic_b + pic_a;
								if (Math.abs(_average - new_a) < _maxDeviation && Math.abs(_average - new_b) < _maxDeviation)
								{
									_binSizes[i_a] = new_a;
									_binSizes[i_b] = new_b;
									_bins[i_a].splice(_bins[i_a].indexOf(pic_a), 1);
									_bins[i_a].push(pic_b);
									_bins[i_b].splice(_bins[i_b].indexOf(pic_b), 1);
									_bins[i_b].push(pic_a);
									_average = sum(_binSizes) / _binSizes.length;
									var deviations:Array = [];
									for (var k:int = 0; k < _binSizes.length; k++)
									{
										deviations.push(Math.abs(_average - _binSizes[k]));
									}

									_maxDeviation = Math.max.apply(null, deviations);
									return true;
								}
							}
						}
					}
				}
			}

			return false;
		}

		private function removeDuplicates(arr:Array) : Array
		{
			var result: Array = arr.concat();
			var i:int;
			var j: int;
			for (i = 0; i < result.length - 1; i++){
				for (j = i + 1; j < result.length; j++){
					if (result[i] === result[j]){
						result.splice(j, 1);
					}
				}
			}
			result.sort(Array.NUMERIC);
			return result;
		}

		private function first_fit(items: Array, bincount: int = Config.DEFAULT_ROWS): void
		{
			items.sort(Array.NUMERIC | Array.DESCENDING);
			for (var i:int = 0; i < bincount; i++)
			{
				_bins.push([]);
				_binSizes.push(0);

			}
			for (var j:int = 0; j < items.length; j++)
			{
				var minBinIndex:int = _binSizes.indexOf(Math.min.apply(null, _binSizes));
				_bins[minBinIndex].push(items[j]);
				_binSizes[minBinIndex] += items[j];
			}

			_average = sum(_binSizes) / bincount;
			var deviations:Array = [];
			for (var k:int = 0; k < _binSizes.length; k++)
			{
				deviations.push(Math.abs(_average - _binSizes[k]));
			}

			_maxDeviation = Math.max.apply(null, deviations);
		}

		private function sum(input:Array):Number
		{
			var total:Number = 0;
			for(var i:Number = 0; i < input.length; i++)
			{
				total += Number(input[i]);
			}
			return total;
		}

	}
}