package robotlegs.service
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;

	import org.robotlegs.mvcs.Actor;

	/**
	 * ImageLoaderService.
	 *
	 */
	public class ImageLoaderService extends Actor implements ILoadService
	{
		private var _queue:LoaderMax;
		private var _onComplete:Function = null;
		// Constructor

		public function ImageLoaderService()
		{
			_queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
		}

		public function add(url: String, onComplete: Function): void
		{
			if (!_queue)
			{
				_queue = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			}
			var loader:ImageLoader = new ImageLoader(url, {name:"photo1", container:this, centerRegistration:false, onComplete:onComplete});

			//begin loading
//			loader.load();

			//append the ImageLoader and several other loaders
			_queue.append( loader );
		}

		public function load(onComplete: Function): void
		{
			_onComplete = onComplete;
			//start loading
			trace("queue", _queue.status);
			if (_queue.status == 0)
			{
				_queue.load();
			}
		}


		private function progressHandler(event:LoaderEvent):void {
			trace("progress: " + _queue.progress);
		}

		private function completeHandler(event:LoaderEvent):void {
			trace(event.target + " is complete!");
			if (_onComplete != null)
			{
				_onComplete();
				_onComplete = null;
			}
			_queue.dispose();
			_queue = null;
		}

		private function errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		// Methods


		// Event handlers

	}
}