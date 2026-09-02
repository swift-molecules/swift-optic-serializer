# swift-optic-serializer

Focused directional lifting from Optic into Serializer.

`Optic Serializer` is the dual of `swift-optic-parser`. Serialization runs
against the flow of parsing, so it consumes an optic's *backward* directions:
Adapter backward application, Isomorphism backward application, Prism embedding,
and Prism matching. Every operation returns `Serializer.Map` — or
`Serializer.Map.Throwing` where the optic direction is partial — and normalizes
failure without exposing unused Optic directions.
