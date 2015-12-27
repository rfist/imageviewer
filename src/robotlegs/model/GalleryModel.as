package robotlegs.model
{
	import mx.collections.ArrayCollection;

	import org.robotlegs.mvcs.Actor;

	import robotlegs.view.GalleryItem;

	/**
	 * GalleryModel.
	 *
	 */
	public class GalleryModel extends Actor
	{

		private var _links:ArrayCollection;
		private var _loadedItems :Vector.<GalleryItem>=new<GalleryItem>[];
		private var _sortedImages:Array = [];

		public function GalleryModel()
		{
			_links = new ArrayCollection();
			_links.addItem("https://cdn.tutsplus.com/active/uploads/legacy/premium/057_advancedSlideshows/deploy/Greensock_Flash_Slideshow_Framework.png");
			_links.addItem("http://www.topfunn.com/wp-content/uploads/2013/08/Bulb_Funny-Picture.jpg");
			_links.addItem("https://upload.wikimedia.org/wikipedia/en/d/d3/No-picture.jpg");
			_links.addItem("http://www.majorgeeks.com/news/file/2728_search.jpg");
			_links.addItem("http://www.dumpaday.com/wp-content/uploads/2015/12/random-pictures-278.jpg");
			_links.addItem("http://natpagle.ru/wp-content/uploads/2014/03/st_randomnumbergenerators_f.jpg");
			_links.addItem("https://pbs.twimg.com/profile_images/1110225360/donkey.jpg");
//			_links.addItem("http://i932.photobucket.com/albums/ad161/YoruZen/random/fe44c770.jpg");
//			_links.addItem("https://pbs.twimg.com/profile_images/378800000138581024/9733bcb490d916fcd2feb5d0abef0cbc_400x400.jpeg");
			_links.addItem("http://www.somerandomfacts.com/wp-content/uploads/2013/11/jpg1");
			_links.addItem("http://images.all-free-download.com/images/graphiclarge/nice_flower_fireworks_270928.jpg");
			_links.addItem("http://media1.santabanta.com/full1/Nature/Birds/birds-284a.jpg");
			_links.addItem("http://www.planwallpaper.com/static/images/hd_nature_wallpaper.jpg");
			_links.addItem("http://change.news/wp-content/uploads/2015/08/Green-Nature-Trees-l.jpg");
			_links.addItem("http://www.familyfriendpoems.com/images/hero/nature-nature.jpg");
			_links.addItem("http://webneel.com/daily/sites/default/files/images/daily/09-2014/7-nature-photography-pedraterrinha.jpg");
			_links.addItem("http://freephotos.atguru.in/hdphotos/nature-spring-wallpapers/nature-spring-2014-11.jpg");
//			_links.addItem("");
//			dispatch(new MessageModelEvent(MessageModelEvent.GALLERY_MODEL_UPDATED));
		}

		public function get linksList():ArrayCollection
		{
			return _links;
		}

		public function get loadedItems(): Vector.<GalleryItem>
		{
			return _loadedItems;
		}

		public function clearMessages():void
		{
			_links.removeAll();
//			dispatch(new MessageModelEvent(MessageModelEvent.MESSAGES_CLEARED));
		}


		public function get sortedImages():Array
		{
			return _sortedImages;
		}

		public function set sortedImages(value:Array):void
		{
			_sortedImages = value;
		}
	}
}