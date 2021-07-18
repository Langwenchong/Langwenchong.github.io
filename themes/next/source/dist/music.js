const ap = new APlayer({
    container: document.getElementById('aplayer'),
	autoplay: true,
	fixed:true,
	listFolded: true,
    audio: [
	{
        name: '君の名字',     
        artist: '新海诚',  
        url: 'https://mp32.9ku.com/upload/128/2016/12/14/856603.mp3', 
		//url:'http://m10.music.126.net/20210118122204/e17e0c88b550b2c296ec11fa180f81c3/ymusic/40b5/d96b/360a/66ae8d390178addc17348db519c317db.mp3',
        cover: 'https://gitee.com/Langwenchong/figure-bed/raw/master/109951163017713493.jpg'
    }
	]
});