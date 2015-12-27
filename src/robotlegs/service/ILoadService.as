/**
 * Created by Vladimir on 26.12.2015.
 */
package robotlegs.service
{
	public interface ILoadService
	{
		function add(url: String, onComplete: Function): void

		function load(onComplete: Function): void
	}
}
