//
//  RingBuffer.swift
//  SwiftAA
//
//  Created by Kihron on 9/8/23.
//

/*
 Fixed-length ring buffer
 
 In this implementation, the read and write pointers always increment and
 never wrap around. On a 64-bit platform that should not get you into trouble
 any time soon.
 
 Not thread-safe, so don't read and write from different threads at the same
 time! To make this thread-safe for one reader and one writer, it should be
 enough to change read/writeIndex += 1 to OSAtomicIncrement64(), but I haven't
 tested this...
 */
struct RingBuffer<T>: RandomAccessCollection {
    private var array: [T?]
    private var readIndex = 0

    init(size: Int) {
        array = Array(repeating: nil, count: size)
    }

    mutating func write(_ element: T) {
        array[readIndex] = element
        readIndex = (readIndex + 1) % array.count
    }

    subscript(index: Int) -> T? {
        return array[(readIndex + index) % array.count]
    }

    var startIndex: Int {
        return 0
    }

    var endIndex: Int {
        return array.count
    }
}
