//
//  TicketView.swift
//  fb4app
//
//  Created by Maurice Hennig on 05.04.23.
//

import SwiftUI
import CoreImage

struct TicketView: View {
    static let ticketUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("semester_ticket.dat")
    
    @State var showTicketImporter = false
    @State var tapScale = false
    @State var imageIsAvailable: Bool = false

    static var previousBrightness = 1.0
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                if (imageIsAvailable) {
                    VStack {
                        ZStack {
                            AsyncImage(url: TicketView.ticketUrl) { image in
                                image
                                    .resizable()
                                    .interpolation(.high)
                                    .antialiased(true)
                                    .frame(height: 280)
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(tapScale ? 2.35 : 1.0, anchor: UnitPoint(x: 0.075, y: 0.955))
                                    .onTapGesture(count: 2) {
                                        withAnimation {
                                            tapScale.toggle()
                                        }
                                    }
                                } placeholder: {
                                    ProgressView()
                                }
                        }
                        ElevatedButton(tapScale ? "Präsentieren beenden" : "Code präsentieren") {
                            withAnimation {
                                tapScale.toggle()
                            }
                            
                            if (tapScale) {
                                TicketView.previousBrightness = UIScreen.main.brightness
                                UIScreen.main.brightness = 1.0
                            } else {
                                UIScreen.main.brightness = TicketView.previousBrightness
                            }
                        }
                    }
                } else {
                    VStack {
                        Text("Es wurde noch kein Semesterticket festgelegt")
                        ElevatedButton("Ticket auswählen") {
                            showTicketImporter.toggle()
                        }
                    }
                    .fileImporter(isPresented: $showTicketImporter, allowedContentTypes: [.pdf]) { result in
                        print("url \(try! result.get())")
                        let file = drawPDFfromURL(url: try! result.get())
                        FileManager.default.createFile(atPath: TicketView.ticketUrl.path(), contents: file?.pngData())
                        imageIsAvailable = true
                    }
                }
                Spacer()
            }
            .onAppear {
                imageIsAvailable = FileManager.default.fileExists(atPath: TicketView.ticketUrl.path())
            }
            .onDisappear {
                UIScreen.main.brightness = TicketView.previousBrightness
            }
            .navigationTitle("Semesterticket")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                if (imageIsAvailable) {
                    ToolbarItem {
                        Button {
                            do {
                                try FileManager.default.removeItem(at: TicketView.ticketUrl)
                                imageIsAvailable = false
                            } catch {
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
    }
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        if (url.startAccessingSecurityScopedResource()) {
            let document = CGPDFDocument(url as CFURL)!
            let page = document.page(at: 1)!

            let pageRect = page.getBoxRect(.mediaBox)
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 540, height: 340))
            let img = renderer.image { ctx in
                UIColor.white.set()
                ctx.fill(pageRect)

                print("height: \(pageRect.size.height)")
                ctx.cgContext.translateBy(x: -120.0, y: 1570)
                ctx.cgContext.scaleBy(x: 2.0, y: -2.0)

                ctx.cgContext.drawPDFPage(page)
            }

            let editImage = CIImage(data: img.pngData()!)
            let luminanceSharpFilter = CIFilter(name: "CISharpenLuminance")
            let maskSharpFilter = CIFilter(name: "CIUnsharpMask")
            
            luminanceSharpFilter?.setValue(editImage, forKey: kCIInputImageKey)
            luminanceSharpFilter?.setValue(0.5, forKey: kCIInputSharpnessKey)
            
            maskSharpFilter?.setValue(luminanceSharpFilter?.outputImage, forKey: kCIInputImageKey)
            maskSharpFilter?.setValue(0.4, forKey: kCIInputIntensityKey)
            
            url.stopAccessingSecurityScopedResource()
            
            return UIImage(ciImage: maskSharpFilter!.outputImage!)
        }
        
        return nil
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView()
    }
}
