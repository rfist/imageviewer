package robotlegs.view
{
	import com.greensock.TweenLite;

	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	import org.osflash.signals.Signal;
	import org.osflash.signals.natives.NativeSignal;
	import org.robotlegs.mvcs.Mediator;

	import robotlegs.model.ImageEvent;

	/**
	 * GalleryItem.
	 *
	 */
	public class GalleryItem extends Mediator
	{

		private var _source:DisplayObject;
		public var fadeSignal:Signal;
		public var clickSignal:NativeSignal;

		public function GalleryItem(image: DisplayObject)
		{
			_source = image;
			fadeSignal = new Signal(Boolean);
			clickSignal = new NativeSignal(_source, MouseEvent.CLICK, MouseEvent);
			fadeSignal.add(onFade);
			clickSignal.add(onClicked);
		}

		// Methods

		public function dispose(): void
		{
			fadeSignal.removeAll();
			fadeSignal = null;
			clickSignal.removeAll();
			clickSignal = null;
			_source.parent.removeChild(_source);
			_source = null;
		}

		public function get source():DisplayObject
		{
			return _source;
		}

		private function onFade(fade: Boolean, onComplete: Function = null): void
		{
			trace('onFade', fade);
			var params:Object = {};
			params.alpha = fade ? 0 : 1;
			if (onComplete != null)
			{
				params.onComplete = onComplete;
			}
			TweenLite.to(source, 1, params);
		}

		private function onClicked(e: *): void
		{
			onFade(true, deleteItem);
		}

		private function deleteItem(): void
		{
			eventDispatcher.dispatchEvent(new ImageEvent(ImageEvent.DELETE_ITEM_REQUESTED, this));
		}

	}
}