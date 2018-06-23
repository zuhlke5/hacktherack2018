import Foundation

class MoodBoardInteractor: MoodBoardInteractorProtocol {

    var presenter: MoodBoardPresenterProtocol?

    func searchWithTerms(_ terms: String) {
        let data = MoodBoardData(
            primaryImage: self.fakePrimaryImage,
            dimensions: self.allDimensions
        )
        self.presenter?.handleResponse(data)
    }

    func searchWithImageId(_ imageId: String) {
        guard let primaryImage = self.allDimensions.flatMap({ dimension -> [MoodBoardData.ImageItem] in return dimension }).first(where: { $0.imageId == imageId }) else {
            return
        }

        let data = MoodBoardData(
            primaryImage: primaryImage,
            dimensions: self.allDimensions.filter({ (dimension) -> Bool in
                return !dimension.contains { $0.imageId == imageId }
            })
        )
        self.presenter?.handleResponse(data)
    }

    var fakePrimaryImage: MoodBoardData.ImageItem = MoodBoardData.ImageItem(imageId: "prim", imageURL: "https://www.lulus.com/images/product/xlarge/2451702_458742.jpg")

    var fakeDataRedDress: [MoodBoardData.ImageItem] = [
        MoodBoardData.ImageItem(imageId: "rd1", imageURL: "https://www.jcrew.com/s7-img-facade/F0791_RD6285"),
        MoodBoardData.ImageItem(imageId: "rd2", imageURL: "https://www.lulus.com/images/product/xlarge/2954720_185074.jpg"),
        MoodBoardData.ImageItem(imageId: "rd3", imageURL: "https://www.lulus.com/images/product/xlarge/2702292_520422.jpg"),
        MoodBoardData.ImageItem(imageId: "rd4", imageURL: "https://www.lulus.com/images/product/xlarge/1108482_173490.jpg"),
        MoodBoardData.ImageItem(imageId: "rd5", imageURL: "https://ladidaboutique.co.uk/wp-content/uploads/2015/12/1012738-Front-e1450444355180.jpg"),
        MoodBoardData.ImageItem(imageId: "rd6", imageURL: "http://dimg.dillards.com/is/image/DillardsZoom/zoom/dear-moon-deep-v-neck-long-dress/05232072_zi_red.jpg")
    ]

    var fakeDataRedSkit: [MoodBoardData.ImageItem] = [
        MoodBoardData.ImageItem(imageId: "rs1", imageURL: "https://pic.elinkmall.com/taobao/CY1062/21.jpg"),
        MoodBoardData.ImageItem(imageId: "rs2", imageURL: "https://images.topshop.com/i/TopShop/TS05T29NTOM_F_1.jpg"),
        MoodBoardData.ImageItem(imageId: "rs3", imageURL: "https://cdn.shopify.com/s/files/1/0902/7306/products/image_ff2f7173-d344-4439-841c-dd64384028c3.jpeg"),
        MoodBoardData.ImageItem(imageId: "rs4", imageURL: "https://images-na.ssl-images-amazon.com/images/I/51qY7mO%2BuyL._UL1500_.jpg"),
        MoodBoardData.ImageItem(imageId: "rs5", imageURL: "http://stylesatlife.com/wp-content/uploads/2017/07/Red-High-Waist-Skirt-for-Women1.jpg"),
        MoodBoardData.ImageItem(imageId: "rs6", imageURL: "https://ae01.alicdn.com/kf/HTB1GMwHdKuSBuNjSsplq6ze8pXaa/5XL-Plus-Size-Skirt-High-Waisted-Skirts-Womens-White-Knee-Length-Bottoms-Pleated-Skirt-Saia-Midi.jpg_640x640.jpg")
    ]

    var fakeDataPinkDress: [MoodBoardData.ImageItem] = [
        MoodBoardData.ImageItem(imageId: "pd1", imageURL: "https://www.jcrew.com/s7-img-facade/F0791_RD6285"),
        MoodBoardData.ImageItem(imageId: "pd2", imageURL: "https://www.lulus.com/images/product/xlarge/3059270_480282.jpg"),
        MoodBoardData.ImageItem(imageId: "pd3", imageURL: "https://shrimps.store/us/media/catalog/product/cache/5/image/9df78eab33525d08d6e5fb8d27136e95/i/r/iris_pink_front_copy.jpg"),
        MoodBoardData.ImageItem(imageId: "pd4", imageURL: "https://ae01.alicdn.com/kf/HTB1x.t5QXXXXXczXXXXq6xXFXXXt/2017-New-Chiffon-Dress-Women-Summer-Casual-Faux-Tiwnset-Styles-Girl-Slim-Pink-Dress-Comfortable-Lady.jpg_640x640.jpg"),
        MoodBoardData.ImageItem(imageId: "pd5", imageURL: "https://www.lilyboutique.com/media/catalog/product/cache/1/image/410x670/9df78eab33525d08d6e5fb8d27136e95/9/5/95_62_.jpg"),
        MoodBoardData.ImageItem(imageId: "pd6", imageURL: "https://ae01.alicdn.com/kf/HTB1ueB.LpXXXXcQXVXXq6xXFXXXH/SISHION-Elegant-Women-Polka-Dots-Dress-Halter-Sexy-Women-Pink-Dress-Rockabilly-Pin-Up-Swing-Vintage.jpg_640x640.jpg")
    ]

    var fakeDataRoseDress: [MoodBoardData.ImageItem] = [
        MoodBoardData.ImageItem(imageId: "rgd1", imageURL: "https://img.promgirl.com/_img/PGPRODUCTS/1469804/320/rose-gold-dress-ML-98017-a.jpg"),
        MoodBoardData.ImageItem(imageId: "rgd2", imageURL: "https://www.lulus.com/images/product/xlarge/1150026_180346.jpg"),
        MoodBoardData.ImageItem(imageId: "rgd3", imageURL: "https://cdn.shopify.com/s/files/1/0310/1937/products/60156_Rose_Gold_front_7f6bd26e-8957-40f1-b9aa-7900bc1348dd.jpg?v=1512683808"),
        MoodBoardData.ImageItem(imageId: "rgd4", imageURL: "https://di2ponv0v5otw.cloudfront.net/posts/2018/04/15/5ad3db2d2c705d024dbe049c/m_5ad3db6185e605c9e6e25b94.jpg"),
        MoodBoardData.ImageItem(imageId: "rgd5", imageURL: "https://cdn.shopify.com/s/files/1/1659/7843/products/romano_dress_1_580x@2x.jpg?v=1499244600"),
        MoodBoardData.ImageItem(imageId: "rgd6", imageURL: "https://cdn.shopify.com/s/files/1/0293/9277/products/Fashion_Nova_07-18-17-135.jpg?v=1525505267")
    ]

    var fakeDataFloorLength: [MoodBoardData.ImageItem] = [
        MoodBoardData.ImageItem(imageId: "fl1", imageURL: "https://img.promgirl.com/_img/PGPRODUCTS/1478478/1000/blush-dress-DQ-9282-c.jpg"),
        MoodBoardData.ImageItem(imageId: "fl2", imageURL: "http://www.dressestime.com/media/catalog/product/cache/1/image/a4feb06c1a64c8a47c5bb0d1ff0f5f86/0/4/04013366.jpg"),
        MoodBoardData.ImageItem(imageId: "fl3", imageURL: "http://www.lalalilo.com/images/products/20150403_1428048520433_1.jpg"),
        MoodBoardData.ImageItem(imageId: "fl4", imageURL: "https://www.ever-pretty.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/e/p/ep08861bd-l_6.jpg"),
        MoodBoardData.ImageItem(imageId: "fl5", imageURL: "http://image21.weroa.com/o_img/2017/02/05/216366-10202816/women-s-elegant-floral-embroidered-floor-length-prom-dress.jpg"),
        MoodBoardData.ImageItem(imageId: "fl6", imageURL: "http://www.manavika.com/wp-content/uploads/2016/01/Green-Chiffon-Floor-Length-Maxi-Dress-.jpg")
    ]

    var allDimensions: [[MoodBoardData.ImageItem]] {
        return [self.fakeDataRedDress, self.fakeDataRedSkit, self.fakeDataPinkDress, self.fakeDataRoseDress, self.fakeDataFloorLength]
    }

}

// MARK: Fake data

//let fakeData: MoodBoardData = MoodBoardData()
